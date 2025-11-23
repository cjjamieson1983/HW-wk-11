resource "aws_security_group" "weblb" {
  name        = "weblb"
  description = "Allow  http for wev tier ALB"
  vpc_id      = aws_vpc.Nov1.id

  tags = {
    Name = "weblb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "weblb-http" {
  description = "Http from anywhere"
  security_group_id = aws_security_group.weblb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

   tags = {
    Name = "http"
  }
}


resource "aws_vpc_security_group_egress_rule" "weblb-http-egresss" {
  description = "Allow all outbound traffic"
  security_group_id = aws_security_group.weblb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
 

  tags = {
    Name = "http-Egress"
  }
}
