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
variable "bastion_ami"           { default = "ami-02c3627b04781eada" }
variable "bastion_instance_type" { default = "t3.micro" }
variable "bastion_key_name"      { default = "tokyo-ec2-key" }
variable "bastion_volume_size"   { default = 8 }

# Private EC2
variable "Private_EC2_ami"           { default = "ami-02c3627b04781eada" }
variable "Private_EC2_instance_type" { default = "t3.micro" }
variable "Private_EC2_key_name"      { default = "tokyo-ec2-key" }
variable "Private_EC2_volume_size"   { default = 8 }