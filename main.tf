terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # define region as per your account
}

resource "aws_s3_bucket" "class54 bucket" {
  bucket = "class54-s3-bucket"

  object_lock_enabled = false

  tags = {
    Environment = "Prod"
  }
}
#===============================
