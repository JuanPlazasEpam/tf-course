output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The CIDR block associated with the VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of the created public subnets."
  value       = [for s in aws_subnet.public : s.id]
}

output "public_subnet_cidr_block" {
  description = "CIDR blocks for all public subnets."
  value       = [for s in aws_subnet.public : s.cidr_block]
}

output "public_subnet_availability_zone" {
  description = "Availability zones for all public subnets."
  value       = [for s in aws_subnet.public : s.availability_zone]
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway attached to the VPC."
  value       = aws_internet_gateway.main.id
}

output "routing_table_id" {
  description = "The ID of the routing table associated with the public subnets."
  value       = aws_route_table.public.id
}

