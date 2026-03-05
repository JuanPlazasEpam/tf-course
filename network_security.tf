data "aws_instance" "public" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private" {
  instance_id = var.private_instance_id
}

resource "aws_security_group" "ssh" {
  name        = "cmtr-gqdgh5re-ssh-sg"
  description = "SSH and ICMP access from allowed IP ranges"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from allowed_ip_range"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "ICMP from allowed_ip_range"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
}

resource "aws_security_group" "public_http" {
  name        = "cmtr-gqdgh5re-public-http-sg"
  description = "Public HTTP and ICMP access from allowed IP ranges"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from allowed_ip_range"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "ICMP from allowed_ip_range"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
}

resource "aws_security_group" "private_http" {
  name        = "cmtr-gqdgh5re-private-http-sg"
  description = "Private HTTP and ICMP access from public HTTP security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from public HTTP security group"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id]
  }

  ingress {
    description     = "ICMP from public HTTP security group"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.public_http.id]
  }
}

resource "aws_network_interface_sg_attachment" "public_ssh" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_instance.public.network_interface_id
}

resource "aws_network_interface_sg_attachment" "public_http" {
  security_group_id    = aws_security_group.public_http.id
  network_interface_id = data.aws_instance.public.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_ssh" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_instance.private.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_http" {
  security_group_id    = aws_security_group.private_http.id
  network_interface_id = data.aws_instance.private.network_interface_id
}

