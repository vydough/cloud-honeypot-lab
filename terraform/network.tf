resource "aws_vpc" "honeypot" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "honeypot" {
  vpc_id = aws_vpc.honeypot.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.honeypot.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}