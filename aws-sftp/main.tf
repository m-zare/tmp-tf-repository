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
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::agencies-sftp-tf/agancy1/"
    }
  ]
}
POLICY
}

resource "aws_transfer_user" "agancy1" {
  server_id = aws_transfer_server.sftp-server.id
  user_name = var.user1
  role      = aws_iam_role.sftp-role.arn
  home_directory = format("/%s/%s", aws_s3_bucket.agencies.bucket, var.user1)
  tags = {
    owner = "mzare"
  }
}

resource "aws_transfer_ssh_key" "agancy1" {
  server_id = aws_transfer_server.sftp-server.id
  user_name = aws_transfer_user.agancy1.user_name
  body      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpyq9KM6h+bGuZNHktEmkwLL2BZ5xPifAZJ7k2GjS9ukpulh1AKuWUEIF74Lx1I1jQVKoGh9HkzFLmM7LEDl2viZ65hvKxIOw52X8GCJSLSJYujCyhXRA57cFJ1BDsDYf8/HiaXZ4tB11KpN3mB9a/xV9aYOpVRwUMuYFx42gYBjmIQkqM7vNOXwf6UxqLenFJHTsQkNhoI1kUsMQ9o357FCgar+05KtBNXDaSnAPazFrJWstskJS4FX+9aT1OPXmzcuCFDkPxwk/pG9axKDbUIScdC58MChd527HJZEWX0U7E6YJCqYxe/gXPpWeCrwiVNw4kJdVNDso8pdaEMckt"
}