data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
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

data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  # Change instance size based on the active workspace
  instance_type = terraform.workspace == "prod" ? "t3.small" : "t3.micro"

  # Include the workspace name in the resource name
  name_prefix = "${var.app_name}-${terraform.workspace}"

  subnet_id = data.aws_subnets.default.ids[0]

  security_group_ids = [
    data.aws_security_group.default.id
  ]
}

resource "aws_instance" "web" {

  ami           = data.aws_ami.al2023.id
  instance_type = local.instance_type

  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.security_group_ids

  tags = {
    #Name        = "web-${terraform.workspace}"
    Name        = "${local.name_prefix}-web"
    Environment = terraform.workspace
  }
}
