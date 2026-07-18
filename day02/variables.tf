###############################################
# Primitive Types
###############################################

# String Variable
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-demo"
}

# Number Variable
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

# Boolean Variable
variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = bool
  default     = true
}

###############################################
# Collection Types
###############################################

# List
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

# Map
variable "tags" {
  description = "Common resource tags"
  type        = map(string)

  default = {
    Owner       = "Sonali"
    Environment = "dev"
    Project     = "Terraform-Learning"
  }
}

# Set
variable "allowed_ips" {
  description = "Unique IP addresses"
  type        = set(string)

  default = [
    "192.168.1.10",
    "192.168.1.11",
    "192.168.1.10"
  ]
}

###############################################
# Structural Types
###############################################

# Object
variable "server_config" {
  description = "Server configuration"

  type = object({
    instance_type = string
    cpu           = number
    monitoring    = bool
  })

  default = {
    instance_type = "t2.micro"
    cpu           = 2
    monitoring    = true
  }
}

# Tuple
variable "server_details" {
  description = "Server details"

  type = tuple([
    string,
    number,
    bool
  ])

  default = [
    "web-server",
    8080,
    true
  ]
}

###############################################
# Validation Example
###############################################

variable "environment" {
  description = "Deployment environment"

  type    = string
  default = "dev"

  validation {
    condition = contains(
      ["dev", "staging", "prod"],
      var.environment
    )

    error_message = "Environment must be one of: dev, staging, prod."
  }
}

###############################################
# Sensitive Variable
###############################################

variable "db_password" {
  description = "Database password"

  type      = string
  sensitive = true
}