# Root module: resolve shared lookups ONCE, then call reusable modules.

#############################################
# Shared Data Sources
#############################################

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for the web server"
  vpc_id      = aws_vpc.main.id
}

#############################################
# Local Values
#############################################

locals {

  subnet_id          = data.aws_subnets.default.ids[0]
  security_group_ids = [data.aws_security_group.default.id]

  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t3.micro"

  common_tags = {
    Project     = "TerraWeek"
    Environment = terraform.workspace
    Owner       = "Sonali"
    ManagedBy   = "Terraform"
  }
}

#############################################
# EC2 Module (Multiple Instances)
#############################################

module "servers" {
  source   = "./modules/ec2_instance"
  for_each = toset(["app", "worker", "cache"])

  name          = each.key
  instance_type = local.instance_type
  environment   = terraform.workspace

  ami                    = data.aws_ami.al2023.id
  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.security_group_ids

  tags = merge(
    local.common_tags,
    {
      Role = each.key
    }
  )
}

#############################################
# VPC Module
#############################################

module "network" {
  source = "./modules/vpc"

  name = "terraweek-vpc"

  cidr = "10.0.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  tags = local.common_tags
}

#############################################
# S3 Bucket (Terraform Registry Module)
#############################################

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.1"

  bucket = "terraweek-sonali-0910-2026"

  versioning = {
    enabled = true
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = local.common_tags
}