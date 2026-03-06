variable "project_prefix" {
  description = "Prefix used for naming AWS network resources created by this configuration."
  type        = string
}

variable "aws_region" {
  description = "AWS region where the network stack will be created."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block to assign to the VPC."
  type        = string
}

variable "public_subnet_azs" {
  description = "List of availability zones for the public subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets. Length must match public_subnet_azs."
  type        = list(string)
}

variable "public_subnet_suffixes" {
  description = "List of suffixes used to build public subnet names. Length must match public_subnet_azs."
  type        = list(string)
}

variable "default_tags" {
  description = "Map of default tags to apply to all supported resources."
  type        = map(string)
}

variable "iam_policy_arn" {
  description = "ARN of the pre-created IAM policy (cmtr-gqdgh5re-iam-policy). Provide via terraform.tfvars or CLI when planning/applying."
  type        = string
  default     = ""
}

