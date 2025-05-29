terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
  }

  # local 
  # backend "s3" {
  #   bucket         = "terraform-state-martian"
  #   key            = "devops/infra/terraform.tfstate"
  #   region         = "us-west-2"
  #   use_lockfile   = true
  #   encrypt        = true
  # }
}


provider "aws" {
  region = "eu-west-1"

  # local mock
  access_key                  = "mock"
  secret_key                  = "mock"
  skip_credentials_validation = true
  skip_requesting_account_id = true
  skip_metadata_api_check    = true
  insecure                   = true
}
