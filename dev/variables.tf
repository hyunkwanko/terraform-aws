# Project
variable "project_name" { default = "k8s-cluster" }
variable "environment" { default = "dev" }

# VPC
variable "cidr_vpc"        { default = "10.0.0.0/16"}
variable "cidr_public_1"    { default = "10.0.0.0/24" }
variable "cidr_public_2"    { default = "10.0.1.0/24" }
variable "cidr_private_1"   { default = "10.0.10.0/24" }
variable "cidr_private_2"   { default = "10.0.11.0/24" }

# Public EC2 (Bastion)
variable "public_ec2_bastion_ami"            { default = "ami-08b2c3a9f2695e351" }
variable "public_ec2_bastion_instance_type"  { default = "t2.medium" }
variable "public_ec2_bastion_key_name"       { default = "public-ec2-bastion-key.pem" }
variable "public_ec2_bastion_volume_size"   { default = 16 }

# Public EC2 (Master)
variable "public_ec2_master_ami"            { default = "ami-08b2c3a9f2695e351" }
variable "public_ec2_master_instance_type"  { default = "t2.medium" }
variable "public_ec2_master_key_name"       { default = "public-ec2-master-key.pem" }
variable "public_ec2_master_volume_size"   { default = 8 }

# Private EC2 (Worker)
variable "private_ec2_worker_ami"           { default = "ami-08b2c3a9f2695e351" }
variable "private_ec2_worker_instance_type" { default = "t2.medium" }
variable "private_ec2_worker_key_name"      { default = "private-ec2-worker-key.pem" }
variable "private_ec2_worker_volume_size"   { default = 8 }