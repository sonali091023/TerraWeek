# Read available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Read the default VPC
data "aws_vpc" "default" {
  default = true
}

# Create a new S3 bucket
resource "aws_s3_bucket" "demo" {
  bucket = "sonali-terraweek-demo-2026july"
}