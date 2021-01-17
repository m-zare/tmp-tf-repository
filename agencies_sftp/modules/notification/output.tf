output "sender" {
  value       = format("%s <%s>", var.senderName, var.senderEmail)
  description = "Sender name and email address"
}

output "recipient" {
  value       = var.recipientEmail
  description = "Recipient email address"
}

output "dynamodb" {
  value       = aws_dynamodb_table.upload_history.name
  description = "Dynamodb table name"
}
