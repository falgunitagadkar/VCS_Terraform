output "cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC."
  value = module.vpc.cidr_block
}

output "vpc_id" {
  description = "The VPC unique identifier."
  value = module.vpc.vpc_id
}

output "igw_id" {
  description = "The InternetGateway unique identifier."
  value = module.vpc.igw_id
}
