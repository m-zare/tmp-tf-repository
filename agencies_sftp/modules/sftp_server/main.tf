# Setup SFTP server resource and the s3 bucket to save date into.
# Acceleration is enabled for the `bucket`. And public access is denied.
# `force_destroy` is disabled by default.

resource "aws_s3_bucket" "bucket" {
  bucket              = var.bucket
  acceleration_status = "Enabled"
  force_destroy       = var.forceDestroy
  versioning {
    enabled = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    owner = "mzare"
  }
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_transfer_server" "sftp_server" {
  identity_provider_type = "SERVICE_MANAGED"

  tags = {
    owner = "mzare"
  }
}
