resource "aws_lambda_function" "send_notification" {
  filename      = "${path.module}/files/send_notification.zip"
  function_name = "send_notification"
  role          = aws_iam_role.lambda_role.arn
  handler       = "send_notification.lambda_handler"

  source_code_hash = filebase64sha256("${path.module}/files/send_notification.zip")

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
