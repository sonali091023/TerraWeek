variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.small"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}


#To create multiple instances, we can use a variable to define the number of instances to be created. This variable can be defined in the variables.tf file and can be used in the main.tf file to create the desired number of instances.
variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 2
}

#To create multiple s3 buckets, we can use a variable to define the number of buckets to be created. This variable can be defined in the variables.tf file and can be used in the main.tf file to create the desired number of buckets.
variable "bucket_names" {
  type = set(string)

  default = [
    "sona-demo-bucket-001",
    "sona-demo-bucket-002"
  ]
}