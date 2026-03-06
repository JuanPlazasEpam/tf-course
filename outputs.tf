output "vpc_id" {
  description = "Discovered VPC ID by name."
  value       = data.aws_vpc.project.id
}

output "public_subnet_id" {
  description = "Discovered public subnet ID by name."
  value       = data.aws_subnet.public.id
}

output "security_group_id" {
  description = "Discovered security group ID by name."
  value       = data.aws_security_group.ec2.id
}

output "instance_id" {
  description = "ID of the created EC2 instance."
  value       = aws_instance.cmtr_instance.id
}

output "instance_private_ip" {
  description = "Private IP of the created EC2 instance."
  value       = aws_instance.cmtr_instance.private_ip
}

output "instance_public_ip" {
  description = "Public IP of the created EC2 instance (if assigned)."
  value       = aws_instance.cmtr_instance.public_ip
}

