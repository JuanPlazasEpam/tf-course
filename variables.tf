variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
}

variable "default_tags" {
  description = "Map of default tags to apply to all resources."
  type        = map(string)
}

variable "project_id" {
  description = "Unique project identifier used for tagging."
  type        = string
}

variable "aws_keypair_name" {
  description = "Name for the EC2 key pair."
  type        = string
}

variable "aws_instance_name" {
  description = "Name tag for the EC2 instance."
  type        = string
}

variable "aws_security_group_name" {
  description = "Name for the EC2 security group."
  type        = string
}

variable "aws_instance_ami" {
  description = "AMI ID for the EC2 instance."
  type        = string
}

variable "aws_instance_type" {
  description = "Instance type for the EC2 instance."
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
  sensitive   = true
}


