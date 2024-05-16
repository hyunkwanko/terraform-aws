###
# $Env:AWS_ACCESS_KEY_ID=""
# $Env:AWS_SECRET_ACCESS_KEY=""
###

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