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
  default = ["my-app-frontend", "my-app-backend"]
}

resource "aws_ecr_repository" "repos" {
  for_each             = toset(var.ecr_repos)
  name                 = each.value
  image_tag_mutability = "MUTABLE"
}

output "repo_urls" {
  for_each = toset(var.ecr_repos)
  value = aws_ecr_repository.repos[each.value].repository_url
}
