
output "vpc_id" {
  value = aws_vpc.infar_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "nat_gateway_ip" {
  value = aws_eip.nat_eip.public_ip
}
output "security_groups_id" {
  value = [aws_security_group.public_sg.id, aws_security_group.private_sg.id]
}