# Public EC2
## Public EC2 (Bastion)
resource "aws_instance" "public-ec2-bastion" {
    ami = "${var.public_ec2_bastion_ami}"
    instance_type = "${var.public_ec2_bastion_instance_type}"
    vpc_security_group_ids = [aws_security_group.public-ec2-bastion-security-group.id]
    iam_instance_profile = aws_iam_instance_profile.bastion-iam-instance-profile.name
    subnet_id = aws_subnet.public-subnet-1.id
    key_name = "${var.public_ec2_bastion_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.public_ec2_bastion_volume_size}"
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

## Public EC2 (Master)
resource "aws_instance" "public-ec2-master-1" {
    ami = "${var.public_ec2_master_ami}"
    instance_type = "${var.public_ec2_master_instance_type}"
    vpc_security_group_ids = [aws_security_group.public-ec2-master-security-group.id]
    iam_instance_profile = aws_iam_instance_profile.master-iam-instance-profile.name
    subnet_id = aws_subnet.public-subnet-2.id
    key_name = "${var.public_ec2_master_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.public_ec2_master_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-public-ec2-master-1"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-public-ec2-master-1"
    }
}

# Prviate EC2
## Prviate EC2 (Worker)
resource "aws_instance" "private-ec2-worker-1" {
    ami = "${var.private_ec2_worker_ami}"
    instance_type = "${var.private_ec2_worker_instance_type}"
    vpc_security_group_ids = [aws_security_group.private-ec2-worker-security-group.id]
    iam_instance_profile = aws_iam_instance_profile.worker-iam-instance-profile.name
    subnet_id = aws_subnet.private-subnet-1.id
    associate_public_ip_address = false
    key_name = "${var.private_ec2_worker_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.private_ec2_worker_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-private-ec2-worker-1"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-ec2-worker-1"
    }
}