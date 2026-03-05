variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tagging."
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair for EC2 instances."
  type        = string
}

