terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-state-bucket-tutorials"
    key    = "workspaces-example/terraform.tfstate"
    region = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-learning-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

#  configure the aws provider
provider "aws" {
  region  = "us-east-2"
  profile = "default"
  # access_key = "${AWS_ACCESS_KEY_ID}"
  # secret_key = "${AWS_SECRET_ACCESS_KEY}"
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = terraform.workspace == "default" ? "t2.micro" : "t2.nano"
}
