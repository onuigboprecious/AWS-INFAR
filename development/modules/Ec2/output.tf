# outputs instance I.D
output "backend_instance_id" {
  value = aws_instance.backend_instance.id
}

# outpus my instance I.P
output "backend_instance_ip" {
  value = aws_instance.backend_instance.private_ip
}
# outputs the state of instance
output "backend_instance_state" {
  value = aws_instance.backend_instance.instance_state
}


