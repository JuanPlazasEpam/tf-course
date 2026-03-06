output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.this.dns_name
}

output "blue_asg" {
  description = "Blue ASG name"
  value       = aws_autoscaling_group.blue.name
}

output "green_asg" {
  description = "Green ASG name"
  value       = aws_autoscaling_group.green.name
}
