module "sftp_server" {
  source = "./modules/sftp_server/"

  bucket = "sftp-agencies"
  force_destroy = var.production
}

module "sftp_user" {
  for_each = var.username
  source   = "./modules/sftp_user/"
  depends_on = [module.sftp_server]

  bucket         = module.sftp_server.bucket
  sftp_server_id = module.sftp_server.id
  username       = each.key
  ssh_key        = each.value
}

module "notification" {
  source   = "./modules/notification/"
  depends_on = [module.sftp_server]
  
  bucket = module.sftp_server.bucket
  serverID = module.sftp_server.id
  senderEmail = "mostafazare@gmail.com"
  recipientEmail = "mostafazare@gmail.com"
}
