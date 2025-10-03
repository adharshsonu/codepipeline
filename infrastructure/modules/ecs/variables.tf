variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type        = string
}

variable "rds_port" {
  description = "RDS port"
  type        = string
}

variable "rds_db_name" {
  description = "RDS database name"
  type        = string
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "ecr_ror_image" {
  description = "ECR image for Rails app"
  type        = string
}

variable "ecr_nginx_image" {
  description = "ECR image for Nginx"
  type        = string
}

# New configurable variables
variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "task_cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "1024"
}

variable "task_memory" {
  description = "Memory for ECS task"
  type        = string
  default     = "2048"
}

#variable "key_name" {
#  description = "EC2 Key Pair name for SSH access"
#  type        = string
#  default     = "" # Set this in your terraform.tfvars
#}