# Project
variable "project_name" { default = "mro" } 
variable "environment" { default = "product" }

# VPC
variable "cidr_vpc"        { default = "10.0.0.0/16"}
variable "cidr_public_1"    { default = "10.0.0.0/24" }

# Public EC2
variable "public_ec2_ami"            { default = "ami-01ed8ade75d4eee2f" }
variable "public_ec2_instance_type"  { default = "t2.micro" }
variable "public_ec2_key_name"       { default = "public-ec2-key.pem" }
variable "public_ec2_volume_size"    { default = 30 }