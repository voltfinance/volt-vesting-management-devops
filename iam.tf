# IAM

# Role

data "aws_iam_policy_document" "codebuild_role" {

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "codepipeline_role" {

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "codebuild-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.codebuild_role.json
}

resource "aws_iam_role" "codepipeline" {
  name               = "codepipeline-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_role.json
}

# Policy

data "aws_iam_policy_document" "codebuild_policy" {

  # Allow VPC configuration
  statement {

    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:ResetNetworkInterfaceAttribute",
      "ec2:DetachNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:RunnerNetworkConfiguration",
      "ec2:DescribeVpcs",
      "ec2:DescribeSecurityGroups"
    ]

    resources = [
      "*"
    ]
  }

  # Allow CodeStar Connection
  statement {

    effect = "Allow"

    actions = [
      "codestar-connections:UseConnection",
    ]

    resources = [
      "*",
    ]
  }

  # S3 - allow access to the CodePipeline S3 artifact
  statement {

    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.codepipeline_artifacts.arn}",
      "${aws_s3_bucket.codepipeline_artifacts.arn}/*"
    ]
  }

  # ECR
  statement {

    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = [
      "*"
    ]
  }

  statement {

    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = [
      "*"
    ]
  }

  # CodeBuild - CloudWatch Log group
  statement {

    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*"
    ]
  }

  # CodeBuild - Report group
  statement {

    effect = "Allow"

    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "CodeBuildBasePolicy-${var.name}"
  path        = "/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

data "aws_iam_policy_document" "codepipeline_policy" {

  # Pass role
  statement {

    effect = "Allow"

    actions = [
      "iam:PassRole",
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEqualsIfExists"
      variable = "iam:PassedToService"

      values = [
        "cloudformation.amazonaws.com",
        "elasticbeanstalk.amazonaws.com",
        "ec2.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }

  # CodeCommit
  statement {

    effect = "Allow"

    actions = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive"
    ]

    resources = [
      "*"
    ]
  }

  # CodeStar Connections
  statement {

    effect = "Allow"

    actions = [
      "codestar-connections:UseConnection"
    ]

    resources = [
      "*"
    ]
  }

  # AWS resources
  statement {

    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*"
    ]

    resources = [
      "*"
    ]
  }

  # CodeBuild
  statement {

    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch"
    ]

    resources = [
      "*"
    ]
  }

  # ECR
  statement {

    effect = "Allow"

    actions = [
      "ecr:DescribeImages"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "AWSCodePipelineServiceRole-${var.name}"
  path        = "/"
  description = "Policy used in trust relationship with CodePipeline"

  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}
