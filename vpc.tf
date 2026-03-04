locals {
  vpc_name                = "${var.project_prefix}-vpc"
  internet_gateway_name   = "${var.project_prefix}-igw"
  public_route_table_name = "${var.project_prefix}-rt"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.default_tags,
    {
      Name = local.vpc_name
    },
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.default_tags,
    {
      Name = local.internet_gateway_name
    },
  )
}

resource "aws_subnet" "public" {
  for_each = {
    for idx, az in var.public_subnet_azs :
    idx => {
      az         = az
      cidr_block = var.public_subnet_cidrs[idx]
      suffix     = var.public_subnet_suffixes[idx]
    }
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    var.default_tags,
    {
      Name = "${var.project_prefix}-subnet-public-${each.value.suffix}"
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
      Name = local.public_route_table_name
    },
  )
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

