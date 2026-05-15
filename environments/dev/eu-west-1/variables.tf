variable "resource_prefix" {
  description = "Resource prefix used for all resource names (e.g. emsp-vpc)"
  type        = string
}

variable "environment_name" {
  description = "Environment name used for resource names (e.g. dev, prod)"
  type        = string

  validation {
    condition = contains(["dev", "staging", "prod", "uat", "infra", "qa"], var.environment_name)
    error_message = "Environment name not supported"
  }
}

# variable "domain_name" {
#   description = "The DNS name of an existing Amazon Route 53 hosted zone"
#   type        = string
#   default = "altosaint.co.uk"

#   validation {
#     condition     = can(regex("^[a-zA-Z0-9]([a-zA-Z0-9.-]{0,61}[a-zA-Z0-9])?$", var.example))
#     error_message = "Must be a valid DNS zone name"
#   }
# }

# variable "db_region" {
#   description = "The eMSP region name i.e., uk, is, es, ie, pt"
#   type        = string

#   validation {
#     condition = contains(["uk", "is", "es", "ie", "pt"], var.environment)
#     error_message = "DB region not supported"
#   }
# }

variable "cidr_prefix" {
  description = "CIDR prefix for VPC"
  type        = string
}

variable "environment_region" {
  description = "Environment region used in resource names/tags"
  type        = string
}

