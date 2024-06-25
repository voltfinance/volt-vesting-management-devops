# - CodeBuild -

resource "aws_codebuild_project" "this" {
  name         = var.name
  description  = "CodeBuild project - ${var.name}"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = "aws/codebuild/standard:6.0"
    privileged_mode = true
    type            = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = file("./codebuild/buildspec/buildspec.yaml")
    git_clone_depth = 0
  }
}
