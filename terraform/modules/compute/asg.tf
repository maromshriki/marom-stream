resource "aws_autoscaling_group" "backend" {
  name                = "backend-asg"
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 100
      instance_warmup        = 300
    }
  }
  tag {
    key                 = "Name"
    value               = "backend-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "frontend" {
  name                = "frontend-asg"
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.frontend_tg.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 100
      instance_warmup        = 300
    }
  }
  tag {
    key                 = "Name"
    value               = "frontend-asg"
    propagate_at_launch = true
  }
}
