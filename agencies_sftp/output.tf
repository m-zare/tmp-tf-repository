output "sftp_server_ID" {
  value       = module.sftp_server.id
  description = "The Transfer Server ID"
}

output "transfer_server_endpoint" {
  value       = module.sftp_server.transfer_server_endpoint
  description = "The endpoint of the Transfer Server"
}

output "bucket" {
  value       = module.sftp_server.bucket
  description = "SFTP bucket name"
}

output "users_list" {
  value       = [for k, _ in var.username : k]
  description = "SFTP user name"
}

output "sender" {
  value       = module.notification.sender
  description = "Sender name and email address"
}

output "recipient" {
  value       = module.notification.recipient
  description = "Recipient email address"
}

output "dynamodb" {
  value       = module.notification.dynamodb
  description = "Dynamodb table name"
}
