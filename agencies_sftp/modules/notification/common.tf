# Common resources used by other configurations are deployed here.

resource "aws_iam_role_policy" "s3ListBucket" {
  name   = "s3ListBucket"
  role   = aws_iam_role.lambda_role.id
  policy = templatefile("${path.module}/templates/s3ListBucket.tpl", { bucket = var.bucket })
}

resource "aws_iam_role_policy" "lambda_logs_email_role" {
  name   = "lambda-execution"
  role   = aws_iam_role.lambda_role.id
  policy = file("${path.module}/files/lambda_logs_email_role.json")
}

resource "aws_iam_role_policy" "sftp_server_readonly_policy" {
  name   = "sftp-server-read-only"
  role   = aws_iam_role.lambda_role.id
  policy = file("${path.module}/files/sftp_server_readonly_policy.json")
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role"
  assume_role_policy = file("${path.module}/files/lambda_role.json")
  tags = {
    owner = "mzare"
  }
}

data "aws_s3_bucket" "selected" {
  bucket = var.bucket
}
