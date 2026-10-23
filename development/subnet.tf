# public subnet 
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.infar_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  count                   = length(var.public_subnet_cidrs)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}


# private subnet
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.infar_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  count                   = length(var.private_subnet_cidrs)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = "false"

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}

