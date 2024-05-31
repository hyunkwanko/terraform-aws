# Security Group
## Public EC2 (Bastion)
resource "aws_security_group" "public-ec2-bastion-security-group"{
    name   = "${var.project_name}-${var.environment}-bastion-security-group"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-bastion-security-group"
    }
}

## Public EC2 (Master)
resource "aws_security_group" "public-ec2-master-security-group"{
    name   = "${var.project_name}-${var.environment}-master-security-group"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-master-security-group"
    }
}

## Private EC2 (Worker)
resource "aws_security_group" "private-ec2-worker-security-group"{
    name   = "${var.project_name}-${var.environment}-worker-security-group"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-${var.environment}-worker-security-group"
    }
}

# Ingress Rules
## Public EC2 (Bastion) - Ingress Rules - 22 (SSH)
resource "aws_security_group_rule" "public-ec2-bastion-security-group-rule-ingress-22" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-bastion-security-group.id
}

## Public EC2 (Bastion) - Ingress Rules - 3000 (Gitea)
resource "aws_security_group_rule" "public-ec2-bastion-security-group-rule-ingress-3000" {
    type                     = "ingress"
    from_port                = 3000
    to_port                  = 3000
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-bastion-security-group.id
}

## Public EC2 (Bastion) - Ingress Rules - 443 (Https)
resource "aws_security_group_rule" "public-ec2-bastion-security-group-rule-ingress-443" {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-bastion-security-group.id
}

## Public EC2 (Master) - Ingress Rules - 22 (SSH)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-22" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - RKE2 server and agent nodes (Node registration. Port should be open on all server nodes to all other nodes in the cluster.)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-9345" {
    type                     = "ingress"
    from_port                = 9345
    to_port                  = 9345
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - RKE2 agent nodes (Kubernetes API)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-6443" {
    type                     = "ingress"
    from_port                = 6443
    to_port                  = 6443
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - RKE2 server and agent nodes (Required only for Flannel VXLAN)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-8472" {
    type                     = "ingress"
    from_port                = 8472
    to_port                  = 8472
    protocol                 = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - RKE2 server and agent nodes (kubelet)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-10250" {
    type                     = "ingress"
    from_port                = 10250
    to_port                  = 10250
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - RKE2 server nodes (etcd client port)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-2379" {
    type                     = "ingress"
    from_port                = 2379
    to_port                  = 2379
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - RKE2 server nodes (etcd peer port)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-2380" {
    type                     = "ingress"
    from_port                = 2380
    to_port                  = 2380
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - Calico-node pod connecting to typha pod (Required when deploying with Calico)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-5473" {
    type                     = "ingress"
    from_port                = 5473
    to_port                  = 5473
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - 80 (Http)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-80" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - 443 (Https)
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-443" {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Public EC2 (Master) - Ingress Rules - ICMP
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-ingress-icmp" {
    type                     = "ingress"
    from_port                = -1
    to_port                  = -1
    protocol                 = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Prviate EC2 (Worker) - Ingress Rules - 22 (SSH)
resource "aws_security_group_rule" "private-ec2-worker-security-group-rule-ingress-22" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}

## Prviate EC2 (Worker) - Ingress Rules - RKE2 server and agent nodes (Node registration. Port should be open on all server nodes to all other nodes in the cluster.)
resource "aws_security_group_rule" "private-ec2-worker-security-group-rule-ingress-9345" {
    type                     = "ingress"
    from_port                = 9345
    to_port                  = 9345
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}

## Prviate EC2 (Worker) - Ingress Rules - RKE2 agent nodes (Kubernetes API)
resource "aws_security_group_rule" "private-ec2-worker-security-group-rule-ingress-6443" {
    type                     = "ingress"
    from_port                = 6443
    to_port                  = 6443
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}

## Prviate EC2 (Worker) - Ingress Rules - RKE2 server and agent nodes (Required only for Flannel VXLAN)
resource "aws_security_group_rule" "private-ec2-worker-security-group-rule-ingress-8472" {
    type                     = "ingress"
    from_port                = 8472
    to_port                  = 8472
    protocol                 = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}

## Prviate EC2 (Worker) - Ingress Rules - RKE2 server and agent nodes (kubelet)
resource "aws_security_group_rule" "private-ec2-worker-security-group-rule-ingress-10250" {
    type                     = "ingress"
    from_port                = 10250
    to_port                  = 10250
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}

## Prviate EC2 (Worker) - Ingress Rules - Calico-node pod connecting to typha pod (Required when deploying with Calico)
resource "aws_security_group_rule" "private-ec2-worker-security-group-rule-ingress-5473" {
    type                     = "ingress"
    from_port                = 5473
    to_port                  = 5473
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}

# Egress Rules
## Public EC2 (Bastion) - Egress Rules - Anywhere
resource "aws_security_group_rule" "public-ec2-bastion-security-group-rule-egress-anywhere" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-bastion-security-group.id
}

## Public EC2 (Master) - Egress Rules - Anywhere
resource "aws_security_group_rule" "public-ec2-master-security-group-rule-egress-anywhere" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-ec2-master-security-group.id
}

## Private EC2 (Worker) - Egress Rules - Anywhere
resource "aws_security_group_rule" "public-ec2-worker-security-group-rule-egress-anywhere" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-ec2-worker-security-group.id
}