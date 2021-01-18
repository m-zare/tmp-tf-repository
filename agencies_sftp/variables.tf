variable "region" {
  default = "eu-west-1"
}

variable "production" {
  description = "Production environment flag"
  type        = bool
}

variable "username" {
  description = "SFTP user"
}

variable "senderName" {
  description = "Name of the sender"
}

variable "senderEmail" {
  description = "Sender email address"
}

variable "recipientEmail" {
  description = "Recipient email address"
}

variable "scheduleExpression" {
  description = "Cron expression for sending out emails"
}
