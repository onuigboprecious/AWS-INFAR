output "endpoint" {
  value = aws_db_instance.infar_db.endpoint
}
output "port" {
  value = aws_db_instance.infar_db.port
}
output "db_instance_identifier" {
  value = aws_db_instance.infar_db.id
}
output "db_instance_arn" {
  value = aws_db_instance.infar_db.arn
}
output "db_instance_status" {
  value = aws_db_instance.infar_db.db_instance_status
}
output "name" {
  value = aws_db_instance.infar_db.name
}
output "engine" {
  value = aws_db_instance.infar_db.engine
} 