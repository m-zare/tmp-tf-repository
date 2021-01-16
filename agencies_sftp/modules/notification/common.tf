resource "aws_iam_role_policy" "dynamodb-policy" {
  name = "dynamodb-policy"
  role = aws_iam_role.lambda_role.id
  policy = templatefile("${path.module}/templates/dynamodb-policy.tpl", { table = aws_dynamodb_table.upload_history.arn })
}

resource "aws_iam_role_policy" "AWSLambdaBasicExecutionRole" {
  name = "lambda-execution"
  role = aws_iam_role.lambda_role.id
  policy = file("${path.module}/files/AWSLambdaBasicExecution_role.json")
}

resource "aws_iam_role_policy" "sftp_server_readonly_policy" {
  name = "sftp-server-read-only"
  role = aws_iam_role.lambda_role.id
  policy = file("${path.module}/files/sftp_server_readonly_policy.json")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"
  assume_role_policy = file("${path.module}/files/lambda_role.json")
  tags = {
    owner = "mzare"
  }
}

data "aws_s3_bucket" "selected" {
  bucket = var.bucket
}
