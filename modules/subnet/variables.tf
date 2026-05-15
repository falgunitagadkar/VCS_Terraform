variable "resource_prefix" {
  description = "Resource prefix used for all resource names (e.g. emsp-vpc)"
  type        = string
}

variable "environment_name" {
  description = "Environment name used for resource names (e.g. dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "Vpc Id"
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]{8,17}$", var.vpc_id))
    error_message = "The vpc_id value must start with 'vpc-' followed by a valid hexadecimal string."
  }
}

variable "gateway_id" {
  description = "Internet Gateway Id"
  type        = string
}

variable "availability_zone" {
  description = "Subnet - Availability Zone"
  type        = string
}

variable "public_cidr_block" {
  description = "Public Subnet - Cidr Block"
  type        = string
}


variable "private_cidr_block" {
  description = "Private Subnet - Cidr Block"
  type        = string
}

variable "environment_region" {
  description = "Environment region used in resource names/tags"
  type        = string
}