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

  description = "Public SSH traffic to honeypot"

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.honeypot.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}