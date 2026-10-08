resource "aws_security_group" "honeypot" {
  name        = "${var.project_name}-sg"
  description = "Security group for Cowrie honeypot"
  vpc_id      = aws_vpc.honeypot.id

  tags = {
    Name = "${var.project_name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "honeypot_ssh" {
  security_group_id = aws_security_group.honeypot.id

  description = "Public SSH traffic to Cowrie"

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  cidr_ipv4 = var.admin_cidr
}

resource "aws_vpc_security_group_ingress_rule" "admin_ssh" {
  security_group_id = aws_security_group.honeypot.id

  description = "Administrative SSH access"

  from_port   = 22222
  to_port     = 22222
  ip_protocol = "tcp"

  cidr_ipv4 = var.admin_cidr
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.honeypot.id

  description = "Allow outbound traffic for package installation and updates"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
