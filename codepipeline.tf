# CodePipeline

resource "aws_codepipeline" "this" {
  name     = var.name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifacts.id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      namespace        = "SourceVariables"
      input_artifacts  = null
      output_artifacts = ["SourceArtifact"]
      run_order        = "1"
      configuration = {
        ConnectionArn    = data.aws_codestarconnections_connection.selected.arn
        FullRepositoryId = "voltfinance/auction-vesting-interface"
        BranchName       = var.github_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      namespace        = "BuildVariables"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      run_order        = "1"
      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      namespace        = "DeployVariables"
      input_artifacts  = ["BuildArtifact"]
      output_artifacts = null
      run_order        = "1"
      configuration = {
        BucketName   = aws_s3_bucket.this.id
        Extract      = "true"
        CacheControl = "max-age=300, public"
      }
    }
  }
}
