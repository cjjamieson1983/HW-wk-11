resource "aws_lb" "web-tier" {
  name               = "web-tier-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.weblb.id]
  subnets            = [aws_subnet.public-us-east-2a.id,
                        aws_subnet.public-us-east-2b.id,
                        aws_subnet.public-us-east-2c.id]

  enable_deletion_protection = false

  

  tags = {
    Name = "web-tier-alb"
  }
}