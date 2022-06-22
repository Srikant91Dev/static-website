
 terraform {

  backend "s3" {
    bucket         = "tf-static-website"
    dynamodb_table = "my-lock-table"
    encrypt        = true
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }

  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      version = "~> 3.0"
    }
  }

  }


provider "aws" {
 region = "us-east-1"
}