resource "aws_lb_target_group" "Web-tier" {
  name     = "Web-tier-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Nov1.id

  health_check {
    enabled = true
    healthy_threshold = 2 #override defualt value of 3
  }

  tags = {
    Name = "Web-Tier-Target-Group"
  }
}