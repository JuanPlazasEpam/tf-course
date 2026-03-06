resource "aws_autoscaling_group" "blue" {
  name                = "cmtr-gqdgh5re-blue-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  target_group_arns = [data.aws_lb_target_group.blue.arn]

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
}

resource "aws_autoscaling_group" "green" {
  name                = "cmtr-gqdgh5re-green-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  target_group_arns = [data.aws_lb_target_group.green.arn]

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
}
