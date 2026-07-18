output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.demo.arn
}