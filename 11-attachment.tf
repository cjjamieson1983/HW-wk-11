# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "web-tier" {
  autoscaling_group_name = aws_autoscaling_group.web-tier.id
  lb_target_group_arn    = aws_lb_target_group.Web-tier.arn
}