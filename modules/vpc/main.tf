locals {
  name_prefix = "/${var.resource_prefix}/${var.environment_name}"
  tag_prefix  = "${var.resource_prefix}-${var.environment_name}"

  # boolean values
  is_production_environment = var.environment_name == "prod"
  is_staging_environment    = var.environment_name == "staging"
}

# VPC ------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name             = "${local.tag_prefix}-website-VPC"
    "iv:environment" = var.environment_name
    "iv:country"     = var.environment_region
    "iv:product"     = "eMSP"
    "iv:object-type" = "EC2 VPC"
  }
}

#VPC-SSM parameter
resource "aws_ssm_parameter" "vpc_id" {
  name        = "${local.name_prefix}/website/vpc-id"
  description = "VPC Id"
  type        = "String"
  value       = aws_vpc.vpc.id

  tags = {
    Name             = "${local.name_prefix}/website/vpc-id"
    "iv:environment" = var.environment_name
    "iv:country"     = var.environment_region
    "iv:product"     = "eMSP"
    "iv:object-type" = "SSM Parameter"
  }
}

resource "aws_ssm_parameter" "ssm_cidr_block" {
  name        = "${local.name_prefix}/website/vpc/cidrblock"
  description = "VPC CIDR Block"
  type        = "String"
  value       = var.cidr_block

  tags = {
    Name             = "${local.name_prefix}/website/vpc/cidrblock"
    "iv:environment" = var.environment_name
    "iv:country"     = var.environment_region
    "iv:product"     = "eMSP"
    "iv:object-type" = "SSM Parameter"
  }
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name             = "${local.tag_prefix}-website-IGW"
    "iv:environment" = var.environment_name
    "iv:country"     = var.environment_region
    "iv:product"     = "eMSP"
    "iv:object-type" = "EC2 InternetGateway"
  }
}

resource "aws_internet_gateway_attachment" "gateway_attachment" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "vpc_flow_log_group" {
  name = "${local.tag_prefix}-website-vpc-flow-LogGroup"

  tags = {
    Name             = "${local.tag_prefix}-website-vpc-flow-LogGroup"
    "iv:environment" = var.environment_name
    "iv:country"     = var.environment_region
    "iv:product"     = "eMSP"
    "iv:object-type" = "VPC flow Log group"
  }
}

data "aws_iam_policy" "cloudwatchlogs_full_access" {
  arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role" "vpc_flow_log_role" {
  name = "${local.tag_prefix}-website-vpc-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name             = "${local.tag_prefix}-website-vpc-flow-log-role"
    "iv:environment" = var.environment_name
    "iv:country"     = var.environment_region
    "iv:product"     = "eMSP"
    "iv:object-type" = "VPC flow log role"
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = aws_iam_role.vpc_flow_log_role.name
  policy_arn = data.aws_iam_policy.cloudwatchlogs_full_access.arn
}

resource "aws_flow_log" "this" {
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn              # !GetAtt VPCFlowLogRole.Arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log_group.arn # !Ref VPCFlowLogGroup
  vpc_id          = aws_vpc.vpc.id
  traffic_type    = "REJECT"
}