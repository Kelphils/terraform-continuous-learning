terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  #   backend configuration for the terraform state in S3 bucket with the DynamoDb table as the backend and encryption, locking enabled
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-state-bucket-for-tutorial"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-learning-locks"
    encrypt        = true
  }
}

#  configure the aws provider
provider "aws" {
  region  = "us-east-2"
  profile = "default"
  # access_key = "${AWS_ACCESS_KEY_ID}"
  # secret_key = "${AWS_SECRET_ACCESS_KEY}"
}
