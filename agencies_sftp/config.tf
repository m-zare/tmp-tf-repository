provider "aws" {
	region = var.region
}

terraform {
	required_version = ">= 0.14"
	backend "s3" {
		bucket = "sftp-terraform-state-bucket"
		key = "tf-state"
		region = "eu-west-1"
		dynamodb_table = "sftp-terraform-state-lock-dynamo"
		encrypt = true
	}
}