# With public subnets attached
resource "aws_alb" "application_load_balancer" {
  name               = "test-lb-tf"
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  /*https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      # certificate_arn    = data.aws_acm_certificate.cert.acm_certificate_arn
      target_group_index = 0
    }
  ]*/
}

# Firewall rules for alb
resource "aws_security_group" "load_balancer_security_group" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Where to direct traffic to (fixed ip addr)
resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path     = "/"
    matcher  = "200-299"
    port     = 80
    protocol = "HTTP"

    interval            = 20
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

# redirecting all incoming traffic from ALB to the target group
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}