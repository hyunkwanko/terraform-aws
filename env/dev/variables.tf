# prj
variable "project_name" { default = "test" } 
variable "environment" { default = "dev" }

# VPC
variable "cidr_vpc"        { default = "10.0.0.0/16"}
variable "cidr_public1"    { default = "10.0.0.0/24" }
variable "cidr_public2"    { default = "10.0.1.0/24" }
variable "cidr_private1"   { default = "10.0.11.0/24" }
variable "cidr_private2"   { default = "10.0.12.0/24" }

# Bastion
variable "bastion_ami"           { default = "ami-0e6f2b2fa0ca704d0" }
variable "bastion_instance_type" { default = "t2.medium" }
variable "bastion_key_name"      { default = "./keyfair/bastion-ec2-key.pem" }
variable "bastion_volume_size"   { default = 8 }

# Private EC2
variable "private_ec2_ami"           { default = "ami-0e6f2b2fa0ca704d0" }
variable "private_ec2_instance_type" { default = "t2.medium" }
variable "private_ec2_key_name"      { default = "./keyfair/private-ec2-key.pem" }
variable "private_ec2_volume_size"   { default = 8 }