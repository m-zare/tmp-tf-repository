module "sftp_server" {
  source = "./modules/sftp_server/"

  bucket       = "sftp-agencies"
  forceDestroy = !var.production
}

module "sftp_user" {
  for_each   = var.username
  source     = "./modules/sftp_user/"
  depends_on = [module.sftp_server]

  bucket       = module.sftp_server.bucket
  sftpServerID = module.sftp_server.id
  username     = each.key
  sshKey       = each.value
}

module "notification" {
  source     = "./modules/notification/"
  depends_on = [module.sftp_server]

  bucket             = module.sftp_server.bucket
  serverID           = module.sftp_server.id
  senderName         = var.senderName
  senderEmail        = var.senderEmail
  recipientEmail     = var.recipientEmail
  scheduleExpression = var.scheduleExpression
}
