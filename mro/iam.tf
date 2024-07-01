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
## Public EC2
resource "aws_iam_role" "public-ec2-iam-role" {
    name               = "${var.project_name}-${var.environment}-iam-role"
    assume_role_policy = data.aws_iam_policy_document.iam-policy-document-assume-role.json
}

resource "aws_iam_role_policy_attachment" "iam-role-policy-attachment-system-manager" {
    role       = aws_iam_role.public-ec2-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-system-manager.arn
}

resource "aws_iam_role_policy_attachment" "iam-role-policy-attachment-cloudwatch-agent" {
    role       = aws_iam_role.public-ec2-iam-role.name
    policy_arn = data.aws_iam_policy.iam-policy-cloudwatch-agent.arn
}

resource "aws_iam_instance_profile" "iam-instance-profile" {
    name = "${var.project_name}-${var.environment}-iam-instance-profile"
    role = aws_iam_role.public-ec2-iam-role.name
}