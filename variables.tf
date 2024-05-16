# prj
variable "project_name" {} 
variable "environment" {}

# network
variable "cidr_vpc" {}
variable "cidr_public1" {}
variable "cidr_public2" {}
variable "cidr_private1" {}
variable "cidr_private2" {}

# Bastion
variable "bastion_ami" {}
variable "bastion_instance_type" {}
variable "bastion_key_name" {}
variable "bastion_volume_size" {}

# Private EC2
variable "private_ec2_ami" {}
variable "private_ec2_instance_type" {}
variable "private_ec2_key_name" {}
variable "private_ec2_volume_size" {}