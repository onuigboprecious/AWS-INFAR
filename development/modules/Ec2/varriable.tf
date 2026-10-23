# Ec2 varriables 

variable "instance_type" {
  description = "An EC2 instance for the backend instance"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-091138d0f0d41ff90"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "infars-vpc"

}
variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  default     = "development"
}


variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch instance in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}
