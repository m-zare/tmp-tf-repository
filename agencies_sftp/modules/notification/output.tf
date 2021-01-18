output "sender" {
  value       = format("%s <%s>", var.senderName, var.senderEmail)
  description = "Sender name and email address"
}

output "recipient" {
  value       = var.recipientEmail
  description = "Recipient email address"
}
