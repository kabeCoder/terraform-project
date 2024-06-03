resource "aws_lb" "kabe-alb" {
  name               = "kabe-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.albSecurityGroupIds]
  subnets            = var.publicSubnetsIds

  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-alb"
    }
  )
}

resource "aws_lb_target_group" "kabe-target-group" {
  name        = "kabe-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpcId

  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-target-group"
    }
  )
}

resource "aws_lb_listener" "kabe-listener" {
  load_balancer_arn = aws_lb.kabe-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.kabe-target-group.arn
    type             = "forward"
  }
}
