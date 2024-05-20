# Public Key Fair
resource "tls_private_key" "public-ec2-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "public-ec2-key-fair" {
    key_name   = "${var.public_ec2_key_name}"
    public_key = tls_private_key.public-ec2-key.public_key_openssh
} 

resource "local_file" "public-ec2-key-fair-local" {
    filename        = "${var.public_ec2_key_name}"
    content         = tls_private_key.public-ec2-key.private_key_pem
    file_permission = "0600"
}

# Private Key Fair
resource "tls_private_key" "private-ec2-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "private-ec2-key-fair" {
    key_name   = "${var.private_ec2_key_name}"
    public_key = tls_private_key.private-ec2-key.public_key_openssh
} 

resource "local_file" "private-ec2-key-fair-local" {
    filename        = "${var.private_ec2_key_name}"
    content         = tls_private_key.private-ec2-key.private_key_pem
    file_permission = "0600"
}