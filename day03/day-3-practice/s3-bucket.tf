resource "aws_s3_bucket" "backup" {
  provider = aws.singapore
  bucket = "sona-backup-2026-demo-0910"
}