variable "vpc_name" {
  description = "Name of the VPC"
  default     = "infars-vpc"
}

variable "db_username" {
  description = "Username for the RDS instance"
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
  # No default — pass via TF_VAR_db_password, a .tfvars file, or Secrets Manager
}

variable "db_name" {
  description = "Name of the database"
  default     = "infar_db"
}

variable "db_instance_class" {
  description = "Instance class for the RDS instance"
  default     = "db.t3.micro" # t2 is previous-gen; t3 is recommended
}

variable "db_engine" {
  description = "Database engine for the RDS instance"
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Engine version for the RDS instance"
  default     = "16.1" # Matches postgres; was "8.0" (a MySQL version)
}

variable "db_allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  default     = 20
}