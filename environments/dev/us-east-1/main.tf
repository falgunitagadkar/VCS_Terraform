module "vpc" {
  source = "../../../modules/vpc"

  resource_prefix    = var.resource_prefix
  environment_name   = var.environment_name
  cidr_block         = "${var.cidr_prefix}.0.0.0/24"
  environment_region = var.environment_region
}

module "subnet" {
  source = "../../../modules/subnet"

  resource_prefix    = var.resource_prefix
  environment_name   = var.environment_name
  vpc_id             = module.vpc.vpc_id
  gateway_id         = module.vpc.igw_id
  availability_zone  = "a"
  public_cidr_block  = "${var.cidr_prefix}.0.0.0/26"
  private_cidr_block = "${var.cidr_prefix}.0.0.64/26"
  environment_region = var.environment_region
}

# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"

#   bucket = "my-s3-bucket-testttt"
#   acl    = "private"

#   control_object_ownership = true
#   object_ownership         = "ObjectWriter"

#   versioning = {
#     enabled = true
#   }
# }
# import {
#   to = aws_subnet.manual
#   id = "subnet-00805e514ec3745c2"
# }