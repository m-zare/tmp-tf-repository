variable "bucket" {

}

variable "serverID" {

}

variable "senderName" {
  default = "AWS SFTP Notification System"
}

variable "senderEmail" {

}
variable "recipientEmail" {

}

variable "schedule_expression" {
  default = "cron(0 8 * * ? *)"
}