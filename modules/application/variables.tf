variable "project_id" {
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch instances into"
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "SSH security group id"
  type        = string
}

variable "private_http_sg_id" {
  description = "Private HTTP security group id"
  type        = string
}

variable "public_http_sg_id" {
  description = "Public HTTP security group id"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key pair name"
  type        = string
}
