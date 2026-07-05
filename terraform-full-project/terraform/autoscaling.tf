resource "aws_autoscaling_group" "frontend" {
  name                      = "${local.name_prefix}-frontend-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = local.private_app_subnet_ids
  target_group_arns         = [aws_lb_target_group.frontend.arn]
  force_delete              = false

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-frontend"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "backend" {
  name                      = "${local.name_prefix}-backend-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = local.private_app_subnet_ids
  target_group_arns         = [aws_lb_target_group.backend.arn]
  force_delete              = false

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-backend"
    propagate_at_launch = true
  }
}
