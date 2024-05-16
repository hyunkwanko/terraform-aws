resource "aws_eip" "nat-ip" {
    lifecycle {
        create_before_destroy = true
    }
}