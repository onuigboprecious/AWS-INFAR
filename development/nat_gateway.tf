# elastic IP for gat gateway 

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "var.vpc_name-nat-eip"
  }

}

# NAT gateway resource for public subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
  depends_on = [aws_internet_gateway.IGW]
}


