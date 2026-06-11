
variable "ecr_repos" {
  default = ["jerin/wpoms-web", "jerin/wpoms-admin"]
}

variable "inbound_rules" {
  default = {
    ssh = {
      cidr_ipv4         = "0.0.0.0/0"
      from_port         = 22
      ip_protocol       = "tcp"
      to_port           = 22
    }
    https = {
      cidr_ipv4         = "0.0.0.0/0"
      from_port         = 443
      ip_protocol       = "tcp"
      to_port           = 443
    }
    http = {
      cidr_ipv4         = "0.0.0.0/0"
      from_port         = 80
      ip_protocol       = "tcp"
      to_port           = 80
    }
  }
}