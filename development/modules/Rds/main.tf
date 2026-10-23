resource "aws_db_instance" "infar_db" {
  allocated_storage           = var.db_allocated_storage
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  instance_class              = var.db_instance_class
  db_name                     = var.db_name
  username                    = var.db_username
  password                    = var.db_password
  parameter_group_name        = "default.postgres13"
  skip_final_snapshot         = true
  db_subnet_group_name        = aws_db_subnet_group.infar_db_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.rds_sg.id]
  multi_az                    = true
  backup_retention_period     = 7
  manage_master_user_password = true


  tags = {
    Name = "${var.vpc_name}-db-instance"
  }

}