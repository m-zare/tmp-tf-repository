output "id" {
  value       = join("", aws_transfer_server.sftp-server.*.id)
  description = "The Transfer Server ID"
}

output "transfer_server_endpoint" {
  value       = join("", aws_transfer_server.sftp-server.*.endpoint)
  description = "The endpoint of the Transfer Server"
}