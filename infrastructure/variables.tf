variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "ror-app"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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
  # No default - must be provided via terraform.tfvars or environment variables
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
  # No default - must be provided to ensure intentional deployment
}

variable "ecr_nginx_image" {
  description = "ECR image URI for Nginx"
  type        = string
  # No default - must be provided to ensure intentional deployment
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

# In modules/ecs/variables.tf
variable "key_name" {
  description = "The name of an existing EC2 Key Pair to enable SSH access to the instances"
  type        = string
  default     = "" # It's good practice to provide a default, even if empty
}

# GitHub OAuth Token for CodePipeline
variable "github_oauth_token" {
  description = "GitHub OAuth token for CodePipeline access"
  type        = string
  sensitive   = true
}