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

resource "aws_iam_role_policy" "dynamodb-putitem" {
  name = "dynamodb-putitem"
  role = aws_iam_role.upload_history.id
  policy = templatefile("${path.module}/templates/dynamodb-putitem.tpl", { table = aws_dynamodb_table.upload_history.arn })
}

resource "aws_iam_role_policy" "AWSLambdaBasicExecutionRole" {
  name = "lambda-execution"
  role = aws_iam_role.upload_history.id
  policy = file("${path.module}/files/AWSLambdaBasicExecutionRole.json")
}

resource "aws_iam_role" "upload_history" {
  name = "upload-history-role"
  assume_role_policy = file("${path.module}/files/role.json")
  tags = {
    owner = "mzare"
  }
}

resource "aws_lambda_function" "upload_history" {
  filename      = "${path.module}/files/s3_upload_history.zip"
  function_name = "s3_upload_history"
  role          = aws_iam_role.upload_history.arn
  handler       = "s3_upload_history.lambda_handler"

  source_code_hash = filebase64sha256("${path.module}/files/s3_upload_history.zip")

  runtime = "python3.7"
  environment {
    variables = {
      Table = aws_dynamodb_table.upload_history.name
    }
  }
  
  tags = {
    owner = "mzare"
  }
}

data "aws_s3_bucket" "selected" {
  bucket = var.bucket
}

resource "aws_s3_bucket_notification" "trigger_upload_history" {
  bucket = data.aws_s3_bucket.selected.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.upload_history.arn
    events              = ["s3:ObjectCreated:*"]
  }
  
  tags = {
    owner = "mzare"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.upload_history.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.selected.arn
  
  tags = {
    owner = "mzare"
  }
}