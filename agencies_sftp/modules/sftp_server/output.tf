output "id" {
  value       = aws_transfer_server.sftp_server.id
  description = "The Transfer Server ID"
}

output "transfer_server_endpoint" {
  value       = aws_transfer_server.sftp_server.endpoint
  description = "The endpoint of the Transfer Server"
}

output "bucket" {
  value       = aws_s3_bucket.bucket.bucket
  description = "SFTP bucket name"
}