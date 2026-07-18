output "container_name" {
  description = "Full name of the running container."
  value       = docker_container.web.name
}

output "access_url" {
  description = "URL to reach the Nginx welcome page."
  value       = format("http://localhost:%d", var.external_port)
}

output "image" {
  description = "The image the container is running."
  value       = docker_image.nginx.name
}

output "project_name" {
  description = "Project name"

  value = var.project_name
}

output "environment" {
  description = "Deployment environment"

  value = var.environment
}

output "name_prefix" {
  description = "Computed name prefix"

  value = local.name_prefix
}

output "common_labels" {
  description = "Merged labels"

  value = local.common_labels
}

output "server_name" {
  description = "Uppercase server name"

    value = local.common_labels["server_name"] 
    #value = lookup(local.common_labels, "server_name", "")


}
