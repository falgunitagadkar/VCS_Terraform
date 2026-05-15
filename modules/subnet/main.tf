resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidr_block
  availability_zone = "${data.aws_region.current.region}${var.availability_zone}"

  tags = {
    Name = "PublicSubnet"
  }
}

data "aws_region" "current" {}

# resource "aws_subnet" "manual" {
#   assign_ipv6_address_on_creation                = "false"
#   cidr_block                                     = "10.0.0.192/26"

#   map_public_ip_on_launch                        = "false"

#   tags = {
#     Name = "Test Subnet"
#   }
  
#   vpc_id = "vpc-049f2c69158c2255d"
# }

