resource "aws_dynamodb_table" "upload_history" {
  name         = "sftp-upload-history"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "object"
  attribute {
    name = "object"
    type = "S"
  }
  tags = {
    owner = "mzare"
  }
}

resource "aws_lambda_function" "upload_history" {
  filename      = "${path.module}/files/s3_upload_history.zip"
  function_name = "s3_upload_history"
  role          = aws_iam_role.lambda_role.arn
  handler       = "s3_upload_history.lambda_handler"

  source_code_hash = filebase64sha256("${path.module}/files/s3_upload_history.zip")

  runtime = "python3.8"
  environment {
    variables = {
      Table = aws_dynamodb_table.upload_history.name
    }
  }

  tags = {
    owner = "mzare"
  }
}

resource "aws_s3_bucket_notification" "trigger_upload_history" {
  bucket = data.aws_s3_bucket.selected.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.upload_history.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.upload_history.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.selected.arn
}