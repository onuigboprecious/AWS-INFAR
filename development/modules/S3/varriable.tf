variable "vpc_name" {
  description = "Name of the VPC"
  default     = "infars-vpc"

}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"

}