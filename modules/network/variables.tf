variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_id" {
  description = "Project id used as name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (3)"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "List of AZs for public subnets (3)"
  type        = list(string)
}
