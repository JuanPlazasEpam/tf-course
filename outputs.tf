output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of IDs of the created public subnets."
  value       = [for s in aws_subnet.public : s.id]
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway attached to the VPC."
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "The ID of the public route table associated with the public subnets."
  value       = aws_route_table.public.id
}

