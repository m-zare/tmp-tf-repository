provider "aws" {
	region = var.region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "aws-sftp-tf"
  versioning {
    enabled = true
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

resource "aws_dynamodb_table" "tf_locks" {
  name = "tf-state-lock-dynamo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    owner = "mzare"
  }
}