# Lambda function to send notification of inactivity.
# It will be triggered base on a cron schedule. On trigger looks into
# a dynamodb table for user activity. If no activity detected an email 
# would be sent.

data "aws_region" "current" {}

resource "aws_ses_email_identity" "notification_sender_email" {
  email = var.senderEmail
}

resource "aws_lambda_function" "send_notification" {
  filename      = "${path.module}/files/send_notification.zip"
  function_name = "send_notification"
  role          = aws_iam_role.lambda_role.arn
  handler       = "send_notification.lambda_handler"

  source_code_hash = filebase64sha256("${path.module}/files/send_notification.zip")

  runtime = "python3.8"
  environment {
    variables = {
      Table          = aws_dynamodb_table.upload_history.name
      ServerID       = var.serverID
      SenderName     = var.senderName
      SenderEmail    = var.senderEmail
      RecipientEmail = var.recipientEmail
      Region         = data.aws_region.current.name
    }
  }

  tags = {
    owner = "mzare"
  }
}

resource "aws_cloudwatch_event_rule" "periodically" {
  name                = "periodic-event-run"
  schedule_expression = "cron(0 8 * * ? *)"

  tags = {
    owner = "mzare"
  }
}

resource "aws_cloudwatch_event_target" "send_notification_periodically" {
  rule = aws_cloudwatch_event_rule.periodically.name
  arn  = aws_lambda_function.send_notification.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_send_notification" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_notification.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.periodically.arn
}
