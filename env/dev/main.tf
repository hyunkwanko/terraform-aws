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

    # Project
    project_name = var.project_name
    environment = var.environment

    # VPC
    cidr_vpc = var.cidr_vpc
    cidr_public1 = var.cidr_public1
    cidr_public2 = var.cidr_public2
    cidr_private1 = var.cidr_private1
    cidr_private2 = var.cidr_private2

    # Public EC2 (Bastion)
    public_ec2_ami           = var.public_ec2_ami
    public_ec2_instance_type = var.public_ec2_instance_type
    public_ec2_key_name      = var.public_ec2_key_name
    public_ec2_volume_size   = var.public_ec2_volume_size

    # Private EC2
    private_ec2_ami           = var.private_ec2_ami
    private_ec2_instance_type = var.private_ec2_instance_type
    private_ec2_key_name      = var.private_ec2_key_name
    private_ec2_volume_size   = var.private_ec2_volume_size
}