# Public EC2
## Public EC2 (Bastion)
resource "aws_instance" "public-ec2-bastion" {
    ami = "${var.public_ec2_ami}"
    instance_type = "${var.public_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.public-ec2.id]
    iam_instance_profile = aws_iam_instance_profile.bastion.name
    subnet_id = aws_subnet.public-subnet-1.id
    key_name = "${var.public_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.public_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-public-ec2-bastion"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-public-ec2-bastion"
    }
}

# Public EC2 (Bastion) - Elastic IP
resource "aws_eip" "public-ec2-bastion-eip" {
    instance = aws_instance.public-ec2-bastion.id
    tags = {
        Name = "${var.project_name}-${var.environment}-bastion-eip"
    }
}

# Prviate EC2
## Prviate EC2-a-1
resource "aws_instance" "private-ec2-a-1" {
    ami = "${var.private_ec2_ami}"
    instance_type = "${var.private_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.private-ec2.id]
    iam_instance_profile = aws_iam_instance_profile.private_ec2.name
    subnet_id = aws_subnet.private-subnet-1.id
    associate_public_ip_address = false
    key_name = "${var.private_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.private_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-private-ec2-a-1"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-ec2-a-1"
    }
}

## Prviate EC2-a-2
resource "aws_instance" "private-ec2-a-2" {
    ami = "${var.private_ec2_ami}"
    instance_type = "${var.private_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.private-ec2.id]
    iam_instance_profile = aws_iam_instance_profile.private_ec2.name
    subnet_id = aws_subnet.private-subnet-1.id
    associate_public_ip_address = false
    key_name = "${var.private_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.private_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-private-ec2-a-2"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-ec2-a-2"
    }
}

# Prviate EC2-c-1
resource "aws_instance" "private-ec2-c-1" {
    ami = "${var.private_ec2_ami}"
    instance_type = "${var.private_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.private-ec2.id]
    iam_instance_profile = aws_iam_instance_profile.private_ec2.name
    subnet_id = aws_subnet.private-subnet-2.id
    associate_public_ip_address = false
    key_name = "${var.private_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.private_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-private-ec2-c-1"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-ec2-c-1"
    }
}