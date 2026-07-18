output "current_workspace" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}

output "instance_type" {
  description = "Instance type based on workspace"
  value       = local.instance_type
}

output "name_prefix" {
  description = "Resource name prefix"
  value       = local.name_prefix
}