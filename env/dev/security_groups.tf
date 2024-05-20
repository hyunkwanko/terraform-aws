# Security Group
## Public EC2 (Bastion)
resource "aws_security_group" "public-ec2"{
    name   = "${var.project_name}-${var.environment}-public-sg"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-public-sg"
    }
}

## Private EC2
resource "aws_security_group" "private-ec2"{
    name   = "${var.project_name}-${var.environment}-private-sg"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-private-sg"
    }
}

# Application Load Balancer
resource "aws_security_group" "alb"{
    name   = "${var.project_name}-${var.environment}-alb-sg"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-alb-sg"
    }
}

# Ingress Rules
## public-ec2-ingress-ssh
resource "aws_security_group_rule" "public-ec2-ingress-ssh" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2.id
}

# ## public-ec2-ingress-9345
# resource "aws_security_group_rule" "public-ec2-ingress-9345" {
#     type                     = "ingress"
#     from_port                = 9345
#     to_port                  = 9345
#     protocol                 = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     security_group_id = aws_security_group.public-ec2.id
# }

# ## public-ec2-ingress-6443
# resource "aws_security_group_rule" "public-ec2-ingress-6443" {
#     type                     = "ingress"
#     from_port                = 6443
#     to_port                  = 6443
#     protocol                 = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     security_group_id = aws_security_group.public-ec2.id
# }

# ## public-ec2-ingress-http
# resource "aws_security_group_rule" "public-ec2-ingress-http" {
#     type                     = "ingress"
#     from_port                = 80
#     to_port                  = 80
#     protocol                 = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     security_group_id = aws_security_group.public-ec2.id
# }

## private-ec2-ingress-ssh
resource "aws_security_group_rule" "private-ec2-ingress-ssh" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2.id
}

## private-ec2-ingress-9345
resource "aws_security_group_rule" "private-ec2-ingress-9345" {
    type                     = "ingress"
    from_port                = 9345
    to_port                  = 9345
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2.id
}

## private-ec2-ingress-6443
resource "aws_security_group_rule" "private-ec2-ingress-6443" {
    type                     = "ingress"
    from_port                = 6443
    to_port                  = 6443
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2.id
}

## private-ec2-ingress-http
resource "aws_security_group_rule" "private-ec2-ingress-http" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2.id
}

## alb-ingress-http
resource "aws_security_group_rule" "alb-ingress-http" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb.id
}

# Egress Rules
## alb-ingress-http
resource "aws_security_group_rule" "public-ec2-egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2.id
}

## private-ec2-egress
resource "aws_security_group_rule" "private-ec2-egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2.id
}

## alb-ec2-egress
resource "aws_security_group_rule" "alb-ec2-egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb.id
}