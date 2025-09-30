variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "ror-app"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"   # updated to your region
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "rds_username" {
  description = "RDS master username"
  type        = string
  default     = "roruser"
}

variable "rds_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  # No default — provide in terraform.tfvars or CLI input
}

variable "rds_db_name" {
  description = "RDS database name"
  type        = string
  default     = "rorappdb"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_port" {
  description = "Port on which RDS listens"
  type        = string
  default     = "5432"
}

variable "ecr_ror_image" {
  description = "ECR image URI for Rails app"
  type        = string
  default     = "612565767098.dkr.ecr.ap-south-1.amazonaws.com/rails:latest"
}

variable "ecr_nginx_image" {
  description = "ECR image URI for Nginx"
  type        = string
  default     = "612565767098.dkr.ecr.ap-south-1.amazonaws.com/nginx:latest"
}
