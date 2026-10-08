resource "aws_key_pair" "honeypot" {
  key_name   = "${var.project_name}-key"
  public_key = file("${path.module}/keys/cloud-honeypot-lab.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "honeypot" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.honeypot.id
  ]

  key_name = aws_key_pair.honeypot.key_name

  iam_instance_profile = aws_iam_instance_profile.honeypot.name

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${var.project_name}-ec2"
  }
}