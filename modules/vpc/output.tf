output "cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC."
  value       = var.cidr_block
}

output "vpc_id" {
  description = "The VPC unique identifier."
  value       = aws_vpc.vpc.id
}

output "igw_id" {
  description = "The InternetGateway unique identifier."
  value       = aws_internet_gateway.igw.id
}


