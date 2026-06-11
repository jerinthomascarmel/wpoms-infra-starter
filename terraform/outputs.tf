output "ecr_repo_urls" {
  value = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}

output "ec2-public-ip" {
  value = aws_instance.terraform-jerin-ec2.public_ip
}
