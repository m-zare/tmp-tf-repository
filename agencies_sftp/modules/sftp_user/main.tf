resource "aws_iam_role" "sftp_role" {
  name = "sftp_role_${var.username}"
  assume_role_policy = file("${path.module}/files/role.json")
  tags = {
    owner = "mzare"
  }
}

locals {
  policy = templatefile("${path.module}/templates/policy.tpl", { username = var.username, bucket = var.bucket })
}

resource "aws_iam_role_policy" "sftp_policy" {
  name = "sftp_iam_policy_${var.username}"
  role = aws_iam_role.sftp_role.id
  policy = local.policy
}

resource "aws_transfer_user" "agency" {
  server_id = var.sftp_server_id
  user_name = var.username
  role      = aws_iam_role.sftp_role.arn
  home_directory = format("/%s/%s", var.bucket, var.username)
  tags = {
    owner = "mzare"
  }
}

resource "aws_transfer_ssh_key" "agency" {
  server_id = var.sftp_server_id
  user_name = aws_transfer_user.agency.user_name
  body      = var.ssh_key
}