output "id" {
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

output "user_list" {
  value       = [for k, _ in var.username : k]
  description = "SFTP user name"
}
