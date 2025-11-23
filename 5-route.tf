########################## Public rtb ##########################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.Nov1.id

  # default gateway route 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public-rtb"
  }
}

resource "aws_route_table_association" "public-us-east-2a" {
  subnet_id      = aws_subnet.public-us-east-2a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-2b" {
  subnet_id      = aws_subnet.public-us-east-2b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-2c" {
  subnet_id      = aws_subnet.public-us-east-2c.id
  route_table_id = aws_route_table.public.id
}



########################## Private rtb ##########################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.Nov1.id

  # default gateway route 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "terraform-private-rtb"
  }
}

resource "aws_route_table_association" "private-us-east-2a" {
  subnet_id      = aws_subnet.private-us-east-2a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-2b" {
  subnet_id      = aws_subnet.private-us-east-2b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-2c" {
  subnet_id      = aws_subnet.private-us-east-2c.id
  route_table_id = aws_route_table.private.id
}