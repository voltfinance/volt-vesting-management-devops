# Terraform - Variables

variable "name" {
  type        = string
  description = "Global - Name"
}

variable "aws_region" {
  type        = string
  description = "AWS - Region"
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS - Profile"
  default     = "563576219775"
}

variable "default_tags" {
  type        = map(any)
  description = "AWS - Default tags"
}

variable "domain" {
  type        = string
  description = "Route53 - Domain"
  default     = "voltage.finance"
}

variable "website" {
  type        = list(string)
  description = "Application - Website hostnames"
}

variable "github_branch" {
  type        = string
  description = "GitHub - Branch"
}
