data "aws_region" "current" {}

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
      ServerID = var.serverID
      SenderName = var.senderName
      SenderEmail = var.senderEmail
      RecipientEmail = var.recipientEmail
      Region = data.aws_region.current.name
    }
  }
  
  tags = {
    owner = "mzare"
  }
}

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
  name = "every-five-minutes"
  description = "Fires every five minutes"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "send_notification_every_five_minutes" {
  rule = aws_cloudwatch_event_rule.every_five_minutes.name
  arn = aws_lambda_function.send_notification.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_send_notification" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.send_notification.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
}
