resource "aws_s3_bucket" "agencies" {
  bucket = "agencies-sftp-tf"
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

resource "aws_transfer_server" "sftp-server" {
  identity_provider_type = "SERVICE_MANAGED"

  tags = {
    owner = "mzare"
  }
}

resource "aws_iam_role" "sftp-role" {
  name = "sftp-role"
  
  tags = {
    owner = "mzare"
  }
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "transfer.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "sftp-policy" {
  name = "sftp-iam-policy"
  role = aws_iam_role.sftp-role.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::agencies-sftp-tf/*"
            ]
        }
    ]
}
POLICY
}
