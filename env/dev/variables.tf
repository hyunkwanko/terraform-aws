# prj
variable "project_name" { default = "k8s" } 
variable "environment" { default = "dev" }

# VPC
variable "cidr_vpc"        { default = "10.0.0.0/16"}
variable "cidr_public1"    { default = "10.0.0.0/24" }
variable "cidr_public2"    { default = "10.0.1.0/24" }
variable "cidr_private1"   { default = "10.0.11.0/24" }
variable "cidr_private2"   { default = "10.0.12.0/24" }

# Bastion
variable "bastion_ami"           { default = "ami-09040d770ffe2224f" }
variable "bastion_instance_type" { default = "t2.micro" }
variable "bastion_key_name"      { default = "bastion-ec2-key.pem" }
variable "bastion_volume_size"   { default = 8 }

# Private EC2
variable "private_ec2_ami"           { default = "ami-09040d770ffe2224f" }
variable "private_ec2_instance_type" { default = "t2.micro" }
variable "private_ec2_key_name"      { default = "private-ec2-key.pem" }
variable "private_ec2_volume_size"   { default = 8 }