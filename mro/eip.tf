# Elastic IP
## Public EC2
resource "aws_eip" "public-ec2-eip" {
    instance = aws_instance.public-ec2.id

    tags = {
        Name = "${var.project_name}-${var.environment}-eip"
    }
}