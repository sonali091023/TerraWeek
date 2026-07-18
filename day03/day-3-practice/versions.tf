terraform {
  #based on this it allows all 1.15.0, 1.15.1, 1.15.8, but it will not allow new range 1.16.x
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}