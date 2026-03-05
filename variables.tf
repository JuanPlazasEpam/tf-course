variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
}

variable "allowed_ip_range" {
  description = "List of IP address ranges (CIDR) allowed to access instances."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the existing VPC provided by the platform."
  type        = string
}

variable "public_instance_id" {
  description = "ID of the existing public EC2 instance provided by the platform."
  type        = string
}

variable "private_instance_id" {
  description = "ID of the existing private EC2 instance provided by the platform."
  type        = string
}

