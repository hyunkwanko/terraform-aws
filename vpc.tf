# VPC
resource "aws_vpc" "vpc" {
    cidr_block           = "${var.cidr_vpc}"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.project_name}-${var.environment}-vpc"
    }
}

# Application Load Balancer
# module "alb" {
#   source = "terraform-aws-modules/alb/aws"

#   name    = "my-alb"
#   vpc_id  = "vpc-abcde012"
#   subnets = ["subnet-abcde012", "subnet-bcde012a"]

#   # Security Group
#   security_group_ingress_rules = {
#     all_http = {
#       from_port   = 80
#       to_port     = 80
#       ip_protocol = "tcp"
#       description = "HTTP web traffic"
#       cidr_ipv4   = "0.0.0.0/0"
#     }
#     all_https = {
#       from_port   = 443
#       to_port     = 443
#       ip_protocol = "tcp"
#       description = "HTTPS web traffic"
#       cidr_ipv4   = "0.0.0.0/0"
#     }
#   }
#   security_group_egress_rules = {
#     all = {
#       ip_protocol = "-1"
#       cidr_ipv4   = "10.0.0.0/16"
#     }
#   }

#   access_logs = {
#     bucket = "my-alb-logs"
#   }

#   listeners = {
#     ex-http-https-redirect = {
#       port     = 80
#       protocol = "HTTP"
#       redirect = {
#         port        = "443"
#         protocol    = "HTTPS"
#         status_code = "HTTP_301"
#       }
#     }
#     ex-https = {
#       port            = 443
#       protocol        = "HTTPS"
#       certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"

#       forward = {
#         target_group_key = "ex-instance"
#       }
#     }
#   }

#   target_groups = {
#     ex-instance = {
#       name_prefix      = "h1"
#       protocol         = "HTTP"
#       port             = 80
#       target_type      = "instance"
#     }
#   }

#   tags = {
#     Environment = "Development"
#     Project     = "Example"
#   }
# }

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-igw"
    }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = aws_subnet.public1.id
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
## public1-subnet
resource "aws_subnet" "public1" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_public1}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public1-subnet"
    }
}

## public2-subnet
resource "aws_subnet" "public2" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2b"
    cidr_block              = "${var.cidr_public2}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-${var.environment}-public2-subnet"
    }
}

## private1-subnet
resource "aws_subnet" "private1" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "${var.cidr_private1}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-${var.environment}-private1-subnet"
    }
}

## private2-subnet
resource "aws_subnet" "private2" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = "ap-northeast-2b"
    cidr_block              = "${var.cidr_private2}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-${var.environment}-private2-subnet"
    }
}


# Route table
## public1~2
resource "aws_route_table" "public1" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-public1-rtb"
    }
}

resource "aws_route_table_association" "public1" {
    subnet_id      = aws_subnet.public1.id
    route_table_id = aws_route_table.public1.id
}

resource "aws_route_table_association" "public2" {
    subnet_id      = aws_subnet.public2.id
    route_table_id = aws_route_table.public1.id
}

resource "aws_route" "public1" {
    route_table_id         = aws_route_table.public1.id
    gateway_id             = aws_internet_gateway.igw.id
    destination_cidr_block = "0.0.0.0/0"
}

## private1~2
resource "aws_route_table" "private1" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-${var.environment}-private1-rtb"
    }
}

resource "aws_route_table_association" "private1" {
    subnet_id      = aws_subnet.private1.id
    route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
    subnet_id      = aws_subnet.private2.id
    route_table_id = aws_route_table.private1.id
}

resource "aws_route" "private1" {
    route_table_id         = aws_route_table.private1.id
    nat_gateway_id         = aws_nat_gateway.nat_gateway.id
    destination_cidr_block = "0.0.0.0/0"
}


# NACL
## public1~2
resource "aws_network_acl" "public1" {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]

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

## private1~2
resource "aws_network_acl" "private1" {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

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
        Name = "${var.project_name}-${var.environment}-private1-nacl"
    }
}