data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64*", "amzn-ami-*-2023*", "amazonlinux-2023*"]
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_id}-template-"
  image_id      = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [var.ssh_sg_id, var.private_http_sg_id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<EOT
#!/bin/bash
# Simple startup: write instance id and uuid to the web root
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id || hostname)
COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid 2>/dev/null || echo unknown)
yum install -y httpd
systemctl enable --now httpd
cat >/var/www/html/index.html <<HTML
<html><body><h1>This message was generated on instance $${INSTANCE_ID} with the following UUID $${COMPUTE_MACHINE_UUID}</h1></body></html>
HTML
EOT
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "${var.project_id}-instance"
      Project   = var.project_id
    }
  }
}

resource "aws_lb" "app" {
  name               = "${var.project_id}-lb"
  load_balancer_type = "application"
  security_groups    = [var.public_http_sg_id]
  subnets            = var.subnet_ids

  tags = {
    Project = var.project_id
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project_id}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.subnet_ids[0] != "" ? cidrhost("0.0.0.0/0",0) : ""
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = "${var.project_id}-asg"
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.this.arn]

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

resource "aws_autoscaling_attachment" "asg_lb" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn    = aws_lb_target_group.this.arn
}
