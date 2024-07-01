# Public EC2
## Public EC2
resource "aws_instance" "public-ec2" {
    ami = "${var.public_ec2_ami}"
    instance_type = "${var.public_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.public-ec2-security-group.id]
    iam_instance_profile = aws_iam_instance_profile.iam-instance-profile.name
    subnet_id = aws_subnet.public-subnet.id
    key_name = "${var.public_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.public_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-public-ec2"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-public-ec2"
    }
}