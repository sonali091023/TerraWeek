#s3Bucket
resource "aws_s3_bucket" "demo" {
  for_each = var.bucket_names

  bucket = each.value

#   lifecycle {
#     prevent_destroy = true
#   }

  tags = {
    Name = each.value
  }
}