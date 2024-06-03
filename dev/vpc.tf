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

# NAT Gateway
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat-gateway-eip.id
    subnet_id     = aws_subnet.public-subnet-1.id
    depends_on    = [aws_internet_gateway.internet-gateway]

    tags = {
        Name = "${var.project_name}-${var.environment}-nat-gateway"
    }
}

# Subnet
## Public Subnet 1
resource "aws_subnet" "public-subnet-1" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_public_1}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public-subnet-1"
    }
}

## Public Subnet 2
resource "aws_subnet" "public-subnet-2" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "${var.cidr_public_2}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public-subnet-2"
    }
}

## Private Subnet 1
resource "aws_subnet" "private-subnet-1" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_private_1}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-${var.environment}-private-subnet-1"
    }
}

## Private Subnet 2
resource "aws_subnet" "private-subnet-2" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "${var.cidr_private_2}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-${var.environment}-private-subnet-2"
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

## Public Route Table Association 1
resource "aws_route_table_association" "public-route-table-association-1" {
    subnet_id      = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

## Public Route Table Association 2
resource "aws_route_table_association" "public-route-table-association-2" {
    subnet_id      = aws_subnet.public-subnet-2.id
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

## Private Route Table Association 1
resource "aws_route_table_association" "private-route-table-association-1" {
    subnet_id      = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-route-table.id
}

## Private Route Table Association 2
resource "aws_route_table_association" "private-route-table-association-2" {
    subnet_id      = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-route-table.id
}

## Private Route
resource "aws_route" "private-route" {
    route_table_id         = aws_route_table.private-route-table.id
    nat_gateway_id         = aws_nat_gateway.nat-gateway.id
    destination_cidr_block = "0.0.0.0/0"
}

# NACL
## Public Network ACL
resource "aws_network_acl" "public-network-acl" {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.public-subnet-1.id, aws_subnet.private-subnet-2.id]

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

## Private Network ACL
resource "aws_network_acl" "private-network-acl" {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

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
        Name = "${var.project_name}-${var.environment}-private-network-acl"
    }
}