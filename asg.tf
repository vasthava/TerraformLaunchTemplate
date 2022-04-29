resource "aws_autoscaling_group" "aws_autoscaling_group" {
  name = local.name
  launch_template {
    id      = aws_launch_template.aws_launch_template.id
    version = "$Latest"
  }
  force_delete = true
  vpc_zone_identifier       = data.aws_subnets.public_subnets.ids
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3
  target_group_arns         = [aws_lb_target_group.tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 180
  tag {
    key                 = "Name"
    value               = local.name
    propagate_at_launch = true
  }
  
}

# resource "aws_autoscaling_attachment" "asg_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.aws_autoscaling_group.id
#   elb                    = aws_lb.aws_lb.id
# }