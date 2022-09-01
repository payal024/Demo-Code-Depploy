resource "aws_lb" "alb" {
  name                       = var.alb-name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["sg-02397964d0fd5b7c3","sg-0c445e7aeca990351"]
  subnets                     = ["subnet-0337d31878ab4be76","subnet-09cbf59af609b530c"]
  enable_deletion_protection = false
  tags                       = local.common_tags
}


resource "aws_lb_target_group" "lb_target" {
  name_prefix = var.target-group-name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0d398f43f914a0f0c"

  health_check {
    interval            = var.health_check_interval
    healthy_threshold   = var.health1_check_threshold
    unhealthy_threshold = var.health_check_threshold
    timeout             = var.health_check_threshold
    path                = var.health-check-path
    port                = var.health-check-port
    matcher             = "200"
  }
  tags = local.common_tags
}

resource "aws_lb_listener" "lb_listener" {
  count             = var.use_https_only == "true" ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}