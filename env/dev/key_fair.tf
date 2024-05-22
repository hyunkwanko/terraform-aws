# Key Fair
## Public Key Fair (Bastion)
resource "tls_private_key" "public-ec2-bastion-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "public-ec2-bastion-key-fair" {
    key_name   = "${var.public_ec2_bastion_key_name}"
    public_key = tls_private_key.public-ec2-bastion-key.public_key_openssh
} 

resource "local_file" "public-ec2-bastion-key-fair-local" {
    filename        = "${var.public_ec2_bastion_key_name}"
    content         = tls_private_key.public-ec2-bastion-key.private_key_pem
    file_permission = "0600"
}

## Public Key Fair (Master)
resource "tls_private_key" "public-ec2-master-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "public-ec2-master-key-fair" {
    key_name   = "${var.public_ec2_master_key_name}"
    public_key = tls_private_key.public-ec2-master-key.public_key_openssh
} 

resource "local_file" "public-ec2-master-key-fair-local" {
    filename        = "${var.public_ec2_master_key_name}"
    content         = tls_private_key.public-ec2-master-key.private_key_pem
    file_permission = "0600"
}

## Private Key Fair (Worker)
resource "tls_private_key" "private-ec2-worker-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "private-ec2-worker-key-fair" {
    key_name   = "${var.private_ec2_worker_key_name}"
    public_key = tls_private_key.private-ec2-worker-key.public_key_openssh
} 

resource "local_file" "private-ec2-worker-key-fair-local" {
    filename        = "${var.private_ec2_worker_key_name}"
    content         = tls_private_key.private-ec2-worker-key.private_key_pem
    file_permission = "0600"
}