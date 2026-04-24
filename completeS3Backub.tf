resource "aws_s3_bucket" "backup_bucket" {
  bucket = "mahmoud-3tier-backup-bucket"

  tags = {
    Name = "backup-bucket"
  }
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backup_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.backup_bucket.id

  rule {
    id     = "backup-lifecycle"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 120
    }
  }
}
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-east-1.s3"

  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private_rt_az1.id,
    aws_route_table.private_rt_az2.id
  ]

  tags = {
    Name = "s3-endpoint"
  }
}