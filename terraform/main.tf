terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
}

variable "ecr_repos" {
  default = ["jerin/wpoms-web", "jerin/wpoms-admin"]
}


resource "aws_ecr_repository" "repos" {
  for_each             = toset(var.ecr_repos)
  name                 = each.value
  image_tag_mutability = "MUTABLE"
}

resource "aws_ami_copy" "ec2" {
  name              = "terraform-jerin-ec2"
  source_ami_id     = "ami-05d62b9bc5a6ca605"

  tags = {
    Name = "terraform-jerin-ec2"
  }
}

output "repo_urls" {
  value = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}
