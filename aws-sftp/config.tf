provider "aws" {
	region = var.region
}

terraform {
	required_version = ">= 0.14"
	backend "s3" {
		bucket = "aws-sftp-tf"
		key = "tf-state"
		region = "eu-west-1"
		dynamodb_table = "tf-state-lock-dynamo"
		encrypt = true
	}
}