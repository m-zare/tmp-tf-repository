resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
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

resource "aws_transfer_server" "sftp_server" {
  identity_provider_type = "SERVICE_MANAGED"

  tags = {
    owner = "mzare"
  }
}