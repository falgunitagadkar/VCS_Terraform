terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.42"
    }
  }

  # cloud {
  #   organization = "IV-Test"
  #   workspaces {
  #     name = "dev-eu-west-1"
  #   }
  # }

  backend "s3" {
    bucket       = "my-terraform-state-testtt-bucket"
    key          = "dev/us-east-1/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}