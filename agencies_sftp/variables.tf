variable "region" {
  default = "eu-west-1"
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
