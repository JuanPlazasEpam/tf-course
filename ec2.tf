resource "aws_vpc" "main" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.default_tags,
    {
      Project = "epam-tf-lab"
      ID      = var.project_id
      Name    = "epam-tf-lab-vpc"
    },
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.default_tags,
    {
      Project = "epam-tf-lab"
      ID      = var.project_id
      Name    = "epam-tf-lab-igw"
    },
  )
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.default_tags,
    {
      Project = "epam-tf-lab"
      ID      = var.project_id
      Name    = "epam-tf-lab-public-subnet-a"
    },
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.default_tags,
    {
      Project = "epam-tf-lab"
      ID      = var.project_id
      Name    = "epam-tf-lab-public-rt"
    },
  )
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ec2" {
  name        = var.aws_security_group_name
  description = "Security group for EC2 instance SSH access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
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

  tags = merge(
    var.default_tags,
    {
      Project = "epam-tf-lab"
      ID      = var.project_id
      Name    = var.aws_security_group_name
    },
  )
}

resource "aws_instance" "this" {
  ami                         = var.aws_instance_ami
  instance_type               = var.aws_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.this.key_name

  tags = merge(
    var.default_tags,
    {
      Project = "epam-tf-lab"
      ID      = var.project_id
      Name    = var.aws_instance_name
    },
  )
}

