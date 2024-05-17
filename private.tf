# EC2
resource "aws_instance" "private-ec2-1" {
    ami = "${var.private_ec2_ami}"
    instance_type = "${var.private_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.private_ec2.id]
    iam_instance_profile = aws_iam_instance_profile.private_ec2.name
    subnet_id = aws_subnet.private1.id
    associate_public_ip_address = false
    key_name = "${var.private_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.private_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-private-ec2-1"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-ec2-1"
    }

    user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update
             sudo apt-get install -y nginx
             sudo systemctl start nginx
             sudo systemctl enable nginx
             echo '<!doctype html>
             <html lang="en"><h1>Home page!</h1></br>
             <h3>(Instance 1)</h3>
             </html>' | sudo tee /var/www/html/index.html
             EOF
}

resource "aws_instance" "private-ec2-2" {
    ami = "${var.private_ec2_ami}"
    instance_type = "${var.private_ec2_instance_type}"
    vpc_security_group_ids = [aws_security_group.private_ec2.id]
    iam_instance_profile = aws_iam_instance_profile.private_ec2.name
    subnet_id = aws_subnet.private2.id
    associate_public_ip_address = false
    key_name = "${var.private_ec2_key_name}"
    disable_api_termination = false

    root_block_device {
        volume_size = "${var.private_ec2_volume_size}"
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "${var.project_name}-${var.environment}-private-ec2-2"
        }
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-ec2-2"
    }

    user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update
             sudo apt-get install -y nginx
             sudo systemctl start nginx
             sudo systemctl enable nginx
             echo '<!doctype html>
             <html lang="en"><h1>Home page!</h1></br>
             <h3>(Instance 2)</h3>
             </html>' | sudo tee /var/www/html/index.html
             EOF
}