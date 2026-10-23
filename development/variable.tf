variable "aws_region" {
  description = "AWS region i'm deploying resources to"
  default     = "us-west-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "infars-vpc"

}


variable "public_subnet_cidrs" {
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}


variable "private_subnet_cidrs" {
  default = ["10.1.3.0/24", "10.1.4.0/24"]
}


variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}

# ------------------------------
# Ec2 varriables 
#-------------------------------

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

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  default     = "development"
}

#--------------------
# S3 varriables
#-------------------- 
