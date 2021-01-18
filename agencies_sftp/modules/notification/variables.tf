variable "bucket" {
  description = "Bucket name"
}

variable "serverID" {
  description = "SFTP server ID"
}

variable "senderName" {
  description = "Name of the sender"
  default     = "AWS SFTP Notification System"
}

variable "senderEmail" {
  description = "Sender email address"
}
variable "recipientEmail" {
  description = "Recipient email address"
}

variable "scheduleExpression" {
  description = "Cron expression for sending out emails"
  default     = "cron(0 8 * * ? *)"
}
