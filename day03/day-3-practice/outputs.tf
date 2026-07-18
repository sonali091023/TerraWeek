output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.backup.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.backup.arn
}

output "bucket_region" {
  description = "AWS region where the bucket is created"
  value       = "ap-southeast-1"
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = aws_s3_bucket.backup.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Regional bucket domain name"
  value       = aws_s3_bucket.backup.bucket_regional_domain_name
}