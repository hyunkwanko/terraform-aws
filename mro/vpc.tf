# VPC
resource "aws_vpc" "vpc" {
    cidr_block           = "${var.cidr_vpc}"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.project_name}-${var.environment}-vpc"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-internet-gateway"
    }
}

# Subnet
## Public Subnet
resource "aws_subnet" "public-subnet" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_public_1}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public-subnet"
    }
}


# Route table
## Public Route Table
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-public-route-table"
    }
}

## Public Route Table Association
resource "aws_route_table_association" "public-route-table-association" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public-route-table.id
}

## Public Route
resource "aws_route" "public-route" {
    route_table_id         = aws_route_table.public-route-table.id
    gateway_id             = aws_internet_gateway.internet-gateway.id
    destination_cidr_block = "0.0.0.0/0"
}

## Private Route Table
resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-private-route-table"
    }
}

# NACL
## Public Network ACL
resource "aws_network_acl" "public-network-acl" {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.public-subnet.id]

    egress {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    ingress {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-public-network-acl"
    }
}