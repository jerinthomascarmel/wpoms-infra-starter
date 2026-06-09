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

resource "aws_ecr_repository" "new_repo" {
  name = "jerin/new"
} 

output "repo_urls" {
  value = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}
