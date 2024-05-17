# Public Key Fair
resource "tls_private_key" "bastion_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key_fair" {
    key_name   = "${var.bastion_key_name}"
    public_key = tls_private_key.bastion_key.public_key_openssh
} 

resource "local_file" "bastion_key_fair_local" {
    filename        = "${var.bastion_key_name}"
    content         = tls_private_key.bastion_key.private_key_pem
    file_permission = "0600"
}

# Private Key Fair
resource "tls_private_key" "private_ec2_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "private_ec2_key_fair" {
    key_name   = "${var.private_ec2_key_name}"
    public_key = tls_private_key.private_ec2_key.public_key_openssh
} 

resource "local_file" "private_ec2_key_fair_local" {
    filename        = "${var.private_ec2_key_name}"
    content         = tls_private_key.private_ec2_key.private_key_pem
    file_permission = "0600"
}