variable "region" {
  default = "eu-west-1"
}

variable "username" {
  description = "SFTP user"

  default = {
    user1 = "public ssh-key"
    user2 = "public ssh-key"
  }
}
