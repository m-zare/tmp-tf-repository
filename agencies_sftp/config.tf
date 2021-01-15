provider "aws" {
	region = var.region
}

terraform {
	required_version = ">= 0.14"
	backend "s3" {
		bucket = "terraform-state"
		key = "tf-state"
		region = "eu-west-1"
		dynamodb_table = "terraform-state-lock-dynamo"
		encrypt = true
	}
}