module "sftp_server" {
  source = "./modules/sftp_server/"

  bucket = "sftp-agencies" 
}

module "sftp_user" {
  source         = "./modules/sftp_user/"
 
  bucket         = sftp_server.bucket
  sftp_server_id = sftp_server.id
  username       = "ftp_user"
  ssh_key        = ""
}
