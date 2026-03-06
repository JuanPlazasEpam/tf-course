data "aws_vpc" "project" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-gqdgh5re-vpc"]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project.id]
  }
}

data "aws_subnet" "public_b" {
  filter {
    name   = "cidr-block"
    values = ["10.0.3.0/24"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project.id]
  }
}

data "aws_security_group" "ec2" {
  filter {
    name   = "group-name"
    values = ["cmtr-gqdgh5re-ec2_sg"]
  }

  vpc_id = data.aws_vpc.project.id
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = ["cmtr-gqdgh5re-http_sg"]
  }

  vpc_id = data.aws_vpc.project.id
}

data "aws_security_group" "lb" {
  filter {
    name   = "group-name"
    values = ["cmtr-gqdgh5re-sglb"]
  }

  vpc_id = data.aws_vpc.project.id
}


resource "aws_launch_template" "this" {
  name          = "cmtr-gqdgh5re-template"
  image_id      = "ami-09e6f87a47903347c"
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = "cmtr-gqdgh5re-instance_profile"
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [
      data.aws_security_group.ec2.id,
      data.aws_security_group.http.id,
    ]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOT
#!/bin/bash
yum update -y
yum install -y awscli httpd jq

systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

cat >/var/www/html/index.html <<EOF
<html>
  <body>
    <h1>This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP</h1>
  </body>
</html>
EOF
EOT
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Terraform = "true"
      Project   = var.project_id
    }
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "cmtr-gqdgh5re-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns,
    ]
  }
}

resource "aws_lb" "this" {
  name               = "cmtr-gqdgh5re-loadbalancer"
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets            = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb_target_group" "this" {
  name     = "cmtr-gqdgh5re-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.project.id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_attachment" "asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn    = aws_lb_target_group.this.arn
}

