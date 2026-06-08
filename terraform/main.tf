terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
}

resource "aws_ecr_repository" "wpoms-web" {
  name                 = "wpoms-web"
}
