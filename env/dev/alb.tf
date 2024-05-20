# Target groups
resource "aws_lb_target_group" "alb-tg" {
    name        = "${var.project_name}-${var.environment}-alb-tg"
    vpc_id      = aws_vpc.vpc.id
    port        = 80
    protocol    = "HTTP"
}

# Target group attachment
## alb-tg-attach-1
resource "aws_lb_target_group_attachment" "alb-tg-attach-1" {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    target_id        = aws_instance.private-ec2-a-1.id
    port             = 80
}

## alb-tg-attach-2
# resource "aws_lb_target_group_attachment" "alb-tg-attach-2" {
#     target_group_arn = aws_lb_target_group.alb-tg.arn
#     target_id        = aws_instance.private-ec2-c-1.id
#     port             = 80
# }

# Application Load Balancer
resource "aws_lb" "alb" {
    name               = "${var.project_name}-${var.environment}-alb"
    internal           = false
    load_balancer_type = "application"
    subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
    security_groups    = [aws_security_group.alb.id]

    tags = {
        Name = "${var.project_name}-${var.environment}-alb"
    }
}

# Listener
resource "aws_lb_listener" "alb-listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.alb-tg.arn
    }
}