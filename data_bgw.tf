data "aws_vpc" "project" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_1]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project.id]
  }
}

data "aws_subnet" "public2" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_2]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project.id]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = [var.sg_ssh]
  }
  vpc_id = data.aws_vpc.project.id
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = [var.sg_http]
  }
  vpc_id = data.aws_vpc.project.id
}

data "aws_security_group" "lb" {
  filter {
    name   = "group-name"
    values = [var.sg_lb]
  }
  vpc_id = data.aws_vpc.project.id
}

data "aws_ami" "al2023" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*al2023*", "*amazon-linux-2023*"]
  }
  owners = ["137112412989"]
}

data "aws_lb_target_group" "blue" {
  name       = var.blue_tg_name
  depends_on = []
}

data "aws_lb_target_group" "green" {
  name       = var.green_tg_name
  depends_on = []
}
