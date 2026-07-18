# output "web_public_ip" {
#   description = "Public IP of the single web server."
#   value       = module.server.public_ip
# }

output "server_ips" {
  description = "Private IPs of every for_each server, keyed by name."
  value       = { for k, m in module.servers : k => m.private_ip }
}

output "server_public_ips" {
  description = "Public IPs of all servers"

  value = {
    for name, server in module.servers :
    name => server.public_ip
  }
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnets" {
  value = module.network.public_subnets
}

output "private_subnets" {
  value = module.network.private_subnets
}

output "default_security_group_id" {
  value = module.network.default_security_group_id
}

output "s3_bucket_id" {
  description = "The name (ID) of the S3 bucket."
  value       = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket."
  value       = module.s3_bucket.s3_bucket_arn
}

output "s3_bucket_region" {
  description = "AWS region where the bucket is created."
  value       = module.s3_bucket.s3_bucket_region
}

output "s3_bucket_domain_name" {
  description = "Bucket domain name."
  value       = module.s3_bucket.s3_bucket_bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  description = "Regional bucket domain name."
  value       = module.s3_bucket.s3_bucket_bucket_regional_domain_name
}


