variable "bucket" {
  type        = string
  description = "Bucket name"
}

variable "sftp_server_id" {
  type        = string
  description = "SFTP server id"
}

variable "username" {
  type        = string
  description = "Agency user"
}

variable "ssh_key" {
  type        = string
  description = "Public SSH key"
}