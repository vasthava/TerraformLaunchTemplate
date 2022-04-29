resource "aws_lb" "aws_lb" {
  name               = "launchTemplateLb"
  internal           = false
  load_balancer_type = "network"
  #security_groups    = [data.aws_security_group.default.id] //Network lb doesn't have security group
  subnets            = data.aws_subnets.public_subnets.ids

  enable_deletion_protection = false

  /* access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  } */

  tags = {
    Environment = "test"
  }
}
resource "aws_lb_target_group" "tg" {
  target_type = "instance"
  name        = "tg443"
  protocol    = "TCP"
  port        = 80
  vpc_id      = data.aws_vpc.default.id
  tags = {
    Name = local.name
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.aws_lb.arn
  port              = aws_lb_target_group.tg.port
  protocol          = aws_lb_target_group.tg.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
