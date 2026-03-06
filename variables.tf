variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_id" {
  description = "Project id used across modules"
  type        = string
  default     = "cmtr-gqdgh5re"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
}

variable "public_subnet_azs" {
  description = "Public subnet AZs"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "allowed_ip_range" {
  description = "Allowed CIDR ranges for access (SSH/HTTP)"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2 instances"
  type        = string
  default     = "cmtr-gqdgh5re-instance_profile"
}

variable "ssh_key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "cmtr-gqdgh5re-keypair"
}


