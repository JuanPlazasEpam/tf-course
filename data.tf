data "aws_vpc" "project" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project.id]
  }
}

data "aws_security_group" "ec2" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }

  vpc_id = data.aws_vpc.project.id
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*al2023*", "*amazon-linux-2023*"]
  }

  owners = ["137112412989"]
}
