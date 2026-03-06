variable "vpc_id" {
  description = "VPC id where SGs will be created"
  type        = string
}

variable "project_id" {
  description = "Project id used for naming"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of allowed CIDR ranges for SSH/HTTP access"
  type        = list(string)
}
