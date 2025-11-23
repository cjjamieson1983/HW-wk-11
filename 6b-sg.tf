resource "aws_security_group" "Nov1-sg" {
  name        = "Nov1-sg"
  description = "Allow  inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Nov1.id

  tags = {
    Name = "Nov1-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Nov1-sg-ssh" {
  description = "SSH from anywhere"
  security_group_id = aws_security_group.Nov1-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

   tags = {
    Name = "SSH"
  }
}


resource "aws_vpc_security_group_ingress_rule" "Nov1-sg-http" {
  description = "Http from anywhere"
  security_group_id = aws_security_group.Nov1-sg.id
  referenced_security_group_id = aws_security_group.weblb.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "http"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Nov1-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }