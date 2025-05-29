variable "name"{
  description = "colony name"
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, prod, martian)"
  type        = string
  default     = "martian"
}
variable "aws_account_id" {
  description = "AWS Account ID where the SNS topic is located"
  type        = string
}