
resource "aws_ecr_repository" "repos" {
  for_each             = toset(var.ecr_repos)
  name                 = each.value
  image_tag_mutability = "MUTABLE"
}

resource "aws_security_group" "terraform_jt_sg" {
  name        = "terraform jt security group"
  description = "Allow HTTP , HTTPS , SSH Access and all outbout access"
  vpc_id      = aws_vpc.default.id

  tags = {
    Name = "terraform_jt_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.terraform_jt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.terraform_jt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.terraform_jt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.terraform_jt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}


resource "aws_instance" "terraform-jerin-ec2" {
  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.terraform_jt_sg.id]
  associate_public_ip_address = true
  key_name = "jt_ec2"
  tags = {
    Name = "terraform-ec2"
  }
}

