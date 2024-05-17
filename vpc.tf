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
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-igw"
    }
}

# NAT Gateway
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = aws_subnet.public-subnet-1.id
    depends_on    = [aws_internet_gateway.igw]

    tags = {
        Name = "${var.project_name}-${var.environment}-nat-gw"
    }
}

# NAT Gateway Eip
resource "aws_eip" "nat_gateway" {
    depends_on = [aws_internet_gateway.igw]

    tags = {
        Name = "${var.project_name}-${var.environment}-nat-gw-eip"
    }
}

# Subnet
## public-subnet-1
resource "aws_subnet" "public-subnet-1" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_public1}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public-subnet-1"
    }
}

## public-subnet-2
resource "aws_subnet" "public-subnet-2" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "${var.cidr_public2}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public-subnet-2"
    }
}

## private-subnet-1
resource "aws_subnet" "private-subnet-1" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_private1}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-${var.environment}-private-subnet-1"
    }
}

## private-subnet-2
resource "aws_subnet" "private-subnet-2" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "${var.cidr_private2}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-${var.environment}-private-subnet-2"
    }
}


# Route table
## public-rt
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-public-rt"
    }
}

## public-rt-association-1
resource "aws_route_table_association" "public-rt-association-1" {
    subnet_id      = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-rt.id
}

## public-rt-association-2
resource "aws_route_table_association" "public-rt-association-2" {
    subnet_id      = aws_subnet.public-subnet-2.id
    route_table_id = aws_route_table.public-rt.id
}

## public-route
resource "aws_route" "public-route" {
    route_table_id         = aws_route_table.public-rt.id
    gateway_id             = aws_internet_gateway.igw.id
    destination_cidr_block = "0.0.0.0/0"
}

## private-rt
resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-private-rt"
    }
}

## private-rt-association-1
resource "aws_route_table_association" "private-rt-association-1" {
    subnet_id      = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-rt.id
}

## private-rt-association-2
resource "aws_route_table_association" "private-rt-association-2" {
    subnet_id      = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-rt.id
}

## private-route
resource "aws_route" "private-route" {
    route_table_id         = aws_route_table.private-rt.id
    nat_gateway_id         = aws_nat_gateway.nat-gateway.id
    destination_cidr_block = "0.0.0.0/0"
}


# NACL
## public-nacl
resource "aws_network_acl" "public-nacl" {
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
        Name = "${var.project_name}-${var.environment}-public-nacl"
    }
}

## private-nacl
resource "aws_network_acl" "private-nacl" {
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
        Name = "${var.project_name}-${var.environment}-private-nacl"
    }
}