// Public

resource "aws_route_table" "x-rtb-ec1-public" {
  vpc_id = aws_vpc.x-vpc-ec1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.x-igw-ec1.id
  }

  tags = {
    Name = "x-rtb-ec1-public"
    Mode = "terraform"
  }
}

resource "aws_route_table_association" "x-rtba-1-public" {
  subnet_id = aws_subnet.x-sbn-1a-public.id
  route_table_id = aws_route_table.x-rtb-ec1-public.id
}

resource "aws_route_table_association" "x-rtba-2-public" {
  subnet_id = aws_subnet.x-sbn-1b-public.id
  route_table_id = aws_route_table.x-rtb-ec1-public.id
}

resource "aws_route_table_association" "x-rtba-3-public" {
  subnet_id = aws_subnet.x-sbn-1c-public.id
  route_table_id = aws_route_table.x-rtb-ec1-public.id
}

// Private

resource "aws_route_table" "x-rtb-ec1-private" {
  vpc_id = aws_vpc.x-vpc-ec1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.x-ngw-ec1.id
  }

  tags = {
    Name = "x-rtb-ec1-private"
    Mode = "terraform"
  }
}

resource "aws_route_table_association" "x-rtba-1-private" {
  subnet_id = aws_subnet.x-sbn-1a-private.id
  route_table_id = aws_route_table.x-rtb-ec1-private.id
}

resource "aws_route_table_association" "x-rtba-2-private" {
  subnet_id = aws_subnet.x-sbn-1b-private.id
  route_table_id = aws_route_table.x-rtb-ec1-private.id
}

resource "aws_route_table_association" "x-rtba-3-private" {
  subnet_id = aws_subnet.x-sbn-1c-private.id
  route_table_id = aws_route_table.x-rtb-ec1-private.id
}