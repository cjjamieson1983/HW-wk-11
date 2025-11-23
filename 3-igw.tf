resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Nov1.id

  tags = {
    Name    = "Nov1_IG"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
}