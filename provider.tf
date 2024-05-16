###
# $Env:AWS_ACCESS_KEY_ID=""
# $Env:AWS_SECRET_ACCESS_KEY=""
###s

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "ap-northeast-2"
}

# Create a VPC
resource "aws_vpc" "example" {
    cidr_block = "10.1.0.0/16"
}