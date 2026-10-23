#private route to the internet gateway

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.infar_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }

}

resource "aws_route_table_association" "nat_gateway_association" {
  subnet_id      = aws_subnet.private[0].id
  route_table_id = aws_route_table.private_route.id

}


# public route to the internet gateway

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.infar_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }

}

resource "aws_route_table_association" "public_gateway_association" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public_route.id

}