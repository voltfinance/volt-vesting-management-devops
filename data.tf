# Terraform - Data

data "aws_region" "current" {}

data "aws_route53_zone" "selected" {
  provider = aws.dns
  name     = var.domain
}

data "aws_codestarconnections_connection" "selected" {
  name = "Voltage-Finance"
}
