resource "aws_dynamodb_table" "upload_history" {
  name         = "sftp-upload-history"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "object"
  attribute {
    name = "object"
    type = "S"
  }
  tags = {
    owner = "mzare"
  }
}

resource "aws_iam_role_policy" "dynamodb-putitem" {
  name = "dynamodb-putitem"
  role = aws_iam_role.upload_history.id
  policy = templatefile("${path.module}/templates/dynamodb-putitem.tpl", { table = aws_dynamodb_table.upload_history.arn })
}

data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "upload_history" {
  name = "upload-history-role"
  assume_role_policy = file("${path.module}/files/role.json")
  policy = aws_iam_role_policy.dynamodb-putitem.policy
  tags = {
    owner = "mzare"
  }
}

resource "aws_iam_policy_attachment" "attach_policy" {
  name       = "attach-AWSLambdaBasicExecutionRole"
  roles      = ["${aws_iam_role.upload_history.name}"]
  policy_arn = data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn}"
}