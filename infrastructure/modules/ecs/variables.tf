variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS resources are deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "rds_endpoint" {
  description = "RDS database endpoint"
  type        = string
}

variable "rds_db_name" {
  description = "RDS database name"
  type        = string
}

variable "rds_username" {
  description = "RDS database username"
  type        = string
}

variable "rds_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}

variable "rds_port" {
  description = "Port on which RDS listens"
  type        = string
  default     = "5432"
}

variable "ecr_ror_image" {
  description = "ECR image URI for the Ruby on Rails application"
  type        = string
}

variable "ecr_nginx_image" {
  description = "ECR image URI for the Nginx container"
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
  default     = "us-east-1"
}
variable "key_name" {
  description = "SSH key pair name for EC2 instances (optional)"
  type        = string
  default     = null
}