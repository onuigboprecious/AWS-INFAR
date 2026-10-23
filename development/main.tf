module "ec2" {
  source             = "./modules/Ec2"
  vpc_name           = var.vpc_name
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = aws_subnet.private[0].id
  security_group_ids = [aws_security_group.private_sg.id]
  environment        = var.environment
}

module "S3" {
  source             = "./modules/S3"
  vpc_name           = var.vpc_name
  security_group_ids = [aws_security_group.public_sg.id]
}

