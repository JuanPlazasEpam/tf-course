resource "aws_lb" "this" {
  name               = "cmtr-gqdgh5re-lb"
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets            = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]

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
    type = "forward"
    forward {
      target_group {
        arn    = data.aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = data.aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }
}
