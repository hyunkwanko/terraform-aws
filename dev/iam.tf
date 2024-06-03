data "aws_iam_policy_document" "iam-policy-document-assume-role" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

data "aws_iam_policy" "iam-policy-system-manager" {
    arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "iam-policy-cloudwatch-agent" {
    arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

# IAM Role
## Public EC2 (Bastion)
resource "aws_iam_role" "public-ec2-bastion-iam-role" {
    name               = "${var.project_name}-${var.environment}-bastion-iam-role"
    assume_role_policy = data.aws_iam_policy_document.iam-policy-document-assume-role.json
}

resource "aws_iam_role_policy_attachment" "bastion-iam-role-policy-attachment-system-manager" {
    role       = aws_iam_role.public-ec2-bastion-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-system-manager.arn
}

resource "aws_iam_role_policy_attachment" "bastion-iam-role-policy-attachment-cloudwatch-agent" {
    role       = aws_iam_role.public-ec2-bastion-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-cloudwatch-agent.arn
}

resource "aws_iam_instance_profile" "bastion-iam-instance-profile" {
    name = "${var.project_name}-${var.environment}-bastion-iam-instance-profile"
    role = aws_iam_role.public-ec2-bastion-iam-role.name
}

## Public EC2 (Master)
resource "aws_iam_role" "public-ec2-master-iam-role" {
    name               = "${var.project_name}-${var.environment}-master-iam-role"
    assume_role_policy = data.aws_iam_policy_document.iam-policy-document-assume-role.json
}

resource "aws_iam_role_policy_attachment" "master-iam-role-policy-attachment-system-manager" {
    role       = aws_iam_role.public-ec2-master-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-system-manager.arn
}

resource "aws_iam_role_policy_attachment" "master-iam-role-policy-attachment-cloudwatch-agent" {
    role       = aws_iam_role.public-ec2-master-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-cloudwatch-agent.arn
}

resource "aws_iam_instance_profile" "master-iam-instance-profile" {
    name = "${var.project_name}-${var.environment}-master-iam-instance-profile"
    role = aws_iam_role.public-ec2-master-iam-role.name
}

## Prviate EC2 (Worker)
resource "aws_iam_role" "private-ec2-worker-iam-role" {
    name               = "${var.project_name}-${var.environment}-worker-iam-role"
    assume_role_policy = data.aws_iam_policy_document.iam-policy-document-assume-role.json
}

resource "aws_iam_role_policy_attachment" "worker-iam-role-policy-attachment-system-manager" {
    role       = aws_iam_role.private-ec2-worker-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-system-manager.arn
}

resource "aws_iam_role_policy_attachment" "worker-iam-role-policy-attachment-cloudwatch-agent" {
    role       = aws_iam_role.private-ec2-worker-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-cloudwatch-agent.arn
}

resource "aws_iam_instance_profile" "worker-iam-instance-profile" {
    name = "${var.project_name}-${var.environment}-worker-iam-instance-profile"
    role = aws_iam_role.private-ec2-worker-iam-role.name
}