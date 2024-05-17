# Security Group
# Bastion EC2
resource "aws_security_group" "bastion_ec2"{
    name   = "${var.project_name}-${var.environment}-bastion-sg"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-bastion-sg"
    }
}

# Private EC2
resource "aws_security_group" "private_ec2"{
    name   = "${var.project_name}-${var.environment}-private-sg"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-private-sg"
    }
}

# Ingress Rules
resource "aws_security_group_rule" "bastion_ec2_ingress_ssh" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.bastion_ec2.id
}

resource "aws_security_group_rule" "private_ec2_ingress_ssh" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private_ec2.id
}

resource "aws_security_group_rule" "private_ec2_ingress_http" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private_ec2.id
}

# Egress Rules
resource "aws_security_group_rule" "bastion_ec2_egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.bastion_ec2.id
}

resource "aws_security_group_rule" "private_ec2_egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private_ec2.id
}