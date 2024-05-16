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

module "dev" {
  source = "../../"

  # prj
  project_name = var.project_name
  environment = var.environment

  # VPC
  cidr_vpc = var.cidr_vpc
  cidr_public1 = var.cidr_public1
  cidr_public2 = var.cidr_public2
  cidr_private1 = var.cidr_private1
  cidr_private2 = var.cidr_private2
}