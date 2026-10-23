resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.infar_vpc.id



  tags = {
    Name = "${var.vpc_name}-igw"
  }
}