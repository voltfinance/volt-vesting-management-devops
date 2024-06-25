# Terraform - Provider

# Default
provider "aws" {

  region = var.aws_region

  default_tags {
    tags = var.default_tags
  }
}

# CloudFront
provider "aws" {
  alias = "cloudfront"

  region = "us-east-1"

  default_tags {
    tags = var.default_tags
  }
}

# DNS
provider "aws" {
  alias = "dns"

  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = var.default_tags
  }
}
