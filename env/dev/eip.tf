# Elastic IP
## Public EC2 (Bastion)
resource "aws_eip" "public-ec2-bastion-eip" {
    instance = aws_instance.public-ec2-bastion.id

    tags = {
        Name = "${var.project_name}-${var.environment}-bastion-eip"
    }
}

## Public EC2 (Master)
resource "aws_eip" "public-ec2-master-eip-1" {
    instance = aws_instance.public-ec2-master-1.id
    
    tags = {
        Name = "${var.project_name}-${var.environment}-master-eip-1"
    }
}

## NAT Gateway
resource "aws_eip" "nat-gateway-eip" {
    depends_on = [aws_internet_gateway.internet-gateway]

    tags = {
        Name = "${var.project_name}-${var.environment}-nat-gateway-eip"
    }
}