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


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "terraform_jt_sg" {
  name        = "terraform-ec2-sg"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-ec2-sg"
  }
}

resource "aws_instance" "terraform-jerin-ec2" {
  ami                    = "ami-05d62b9bc5a6ca605"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.terraform_jt_sg.id]
  key_name = "jt_ec2"
  tags = {
    Name = "terraform-ec2"
  }
}


output "repo_urls" {
  value = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}

output "ec2-public-ip" {
  value = aws_instance.terraform-jerin-ec2.public_ip
}
