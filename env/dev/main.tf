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

    # Public EC2
    bastion_ami           = var.bastion_ami
    bastion_instance_type = var.bastion_instance_type
    bastion_key_name      = var.bastion_key_name
    bastion_volume_size   = var.bastion_volume_size

    # Private EC2
    private_ec2_ami           = var.private_ec2_ami
    private_ec2_instance_type = var.private_ec2_instance_type
    private_ec2_key_name      = var.private_ec2_key_name
    private_ec2_volume_size   = var.private_ec2_volume_size
}