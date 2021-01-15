module "sftp_server" {
  source = "./modules/sftp_server/"

  bucket = "sftp-agencies"
}

module "sftp_user" {
  for_each = var.username
  source   = "./modules/sftp_user/"

  bucket         = module.sftp_server.bucket
  sftp_server_id = module.sftp_server.id
  username       = each.key
  ssh_key        = each.value
}
