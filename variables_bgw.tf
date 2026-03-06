variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_id" {
  description = "Project identifier used for naming and tagging"
  type        = string
  default     = "cmtr-gqdgh5re"
}

variable "vpc_name" {
  description = "Name tag of the VPC to discover"
  type        = string
  default     = "cmtr-gqdgh5re-vpc"
}

variable "public_subnet_1" {
  description = "Name tag of public subnet 1"
  type        = string
  default     = "cmtr-gqdgh5re-public-subnet1"
}

variable "public_subnet_2" {
  description = "Name tag of public subnet 2"
  type        = string
  default     = "cmtr-gqdgh5re-public-subnet2"
}

variable "sg_ssh" {
  description = "Security group name that allows SSH"
  type        = string
  default     = "cmtr-gqdgh5re-sg-ssh"
}

variable "sg_http" {
  description = "Security group name that allows HTTP to instances"
  type        = string
  default     = "cmtr-gqdgh5re-sg-http"
}

variable "sg_lb" {
  description = "Security group name for the Load Balancer"
  type        = string
  default     = "cmtr-gqdgh5re-sg-lb"
}

variable "ssh_key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = "cmtr-gqdgh5re-keypair"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2 instances"
  type        = string
  default     = "cmtr-gqdgh5re-instance_profile"
}

variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group. Specifies the percentage of traffic routed to the Blue environment."
  type        = number
  default     = 100
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group. Specifies the percentage of traffic routed to the Green environment."
  type        = number
  default     = 0
}

variable "blue_tg_name" {
  description = "Name of the Blue target group"
  type        = string
  default     = "cmtr-gqdgh5re-blue-tg"
}

variable "green_tg_name" {
  description = "Name of the Green target group"
  type        = string
  default     = "cmtr-gqdgh5re-green-tg"
}
