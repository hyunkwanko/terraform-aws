# Security Group
## Public EC2
resource "aws_security_group" "public-ec2-security-group"{
    name   = "${var.project_name}-${var.environment}-security-group"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-security-group"
    }
}

# Ingress Rules
## Public EC2 - Ingress Rules - 22 (SSH)
resource "aws_security_group_rule" "public-ec2-security-group-rule-ingress-22" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-security-group.id
}

## Public EC2 - Ingress Rules - 80 (Http)
resource "aws_security_group_rule" "public-ec2-security-group-rule-ingress-80" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-security-group.id
}

## Public EC2 - Ingress Rules - 443 (Https)
resource "aws_security_group_rule" "public-ec2-security-group-rule-ingress-443" {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-security-group.id
}

# Egress Rules
## Public EC2 (Bastion) - Egress Rules - Anywhere
resource "aws_security_group_rule" "public-ec2-bastion-security-group-rule-egress-anywhere" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-security-group.id
}