output "ecr_repo_urls" {
  value = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}

output "terraform-jerin-ec2-details" {
  value = {
    public_ip = aws_instance.terraform-jerin-ec2.public_ip
    dns_name  = aws_instance.terraform-jerin-ec2.public_dns_name
  }
}
