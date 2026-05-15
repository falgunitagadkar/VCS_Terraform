variable "resource_prefix" {
  description = "Resource prefix used for all resource names (e.g. emsp-vpc)"
  type        = string
}

variable "environment_name" {
  description = "Environment name used for resource names (e.g. dev, prod)"
  type        = string
}

variable "cidr_block" {
  description = "Primary IPv4 CIDR block for the VPC"
  type        = string
}

variable "environment_region" {
  description = "Environment region used in resource names/tags"
  type        = string
}