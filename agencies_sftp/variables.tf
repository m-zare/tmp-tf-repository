variable "region" {
  default = "eu-west-1"
}

variable "production" {
  description = "Production environment flag"
  type        = bool
  default     = false
}

variable "username" {
  description = "SFTP user"

  default = {
    # # Read ssh key from string
    # user1 = "ssh-rsa ..."
    # # Read ssh key from file
    # user2 = "~/sftp.pub"
  }
}

variable "senderName" {
  description = "Name of the sender"
  default     = "AWS SFTP Notification System"
}

variable "senderEmail" {
  description = "Sender email address"
  default     = "mostafazare@gmail.com"
}

variable "recipientEmail" {
  description = "Recipient email address"
  default     = "mostafazare@gmail.com"
}

variable "scheduleExpression" {
  description = "Cron expression for sending out emails"
  default     = "cron(0 8 * * ? *)"
}
