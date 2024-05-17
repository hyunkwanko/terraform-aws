# Project
variable "project_name" {} 
variable "environment" {}

# VPC
variable "cidr_vpc" {}
variable "cidr_public1" {}
variable "cidr_public2" {}
variable "cidr_private1" {}
variable "cidr_private2" {}

# Public EC2 (Bastion)
variable "public_ec2_ami" {}
variable "public_ec2_instance_type" {}
variable "public_ec2_key_name" {}
variable "public_ec2_volume_size" {}

# Private EC2
variable "private_ec2_ami" {}
variable "private_ec2_instance_type" {}
variable "private_ec2_key_name" {}
variable "private_ec2_volume_size" {}