resource "aws_autoscaling_group" "web-tier" {
  name = "web-servr-Asg"
  vpc_zone_identifier = [aws_subnet.private-us-east-2a.id,
                         aws_subnet.private-us-east-2b.id,
                         aws_subnet.private-us-east-2c.id]
          
  max_size            = 6
  min_size            = 3 
  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.Web-tier.arn]

  launch_template {
    id = aws_launch_template.web_tier.id
    version ="$Latest"
  }

  tag {
    key = "name"
    value = "web-instance"
    propagate_at_launch = true
  }

  force_delete = true

}