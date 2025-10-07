terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Updated to latest version
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Networking Module: VPC, subnets, NAT, IGW, route tables
module "networking" {
  source               = "./modules/networking"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# RDS Module: PostgreSQL DB inside private subnets
module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  vpc_id             = module.networking.vpc_id
  private_subnets    = module.networking.private_subnet_ids
  rds_username       = var.rds_username
  rds_password       = var.rds_password
  rds_db_name        = var.rds_db_name
  rds_instance_class = var.rds_instance_class
  rds_port           = var.rds_port
}

# ECS Module: ECS cluster with EC2 capacity provider
module "ecs" {
  source          = "./modules/ecs"
  project_name    = var.project_name
  aws_region      = var.aws_region
  vpc_id          = module.networking.vpc_id
  public_subnets  = module.networking.public_subnet_ids
  private_subnets = module.networking.private_subnet_ids

  rds_endpoint   = module.rds.rds_endpoint
  rds_port       = var.rds_port
  rds_db_name    = var.rds_db_name
  rds_username   = var.rds_username
  rds_password   = var.rds_password

  ecr_ror_image   = var.ecr_ror_image
  ecr_nginx_image = var.ecr_nginx_image
  
  # New configurable variables
  log_retention_days = var.log_retention_days
  task_cpu           = var.task_cpu
  task_memory        = var.task_memory
}

# CodePipeline Module with GitHub Integration
module "codepipeline" {
  source          = "./modules/codepipeline"
  project_name    = var.project_name
  aws_region      = var.aws_region
  aws_account_id  = "612565767098" # Your AWS account ID

  # GitHub configuration
  github_owner      = "adharshsonu" # Replace with your GitHub username/organization
  github_repo       = "codepipeline" # Replace with your repository name
  github_branch     = "main"
  github_oauth_token = var.github_oauth_token # Set this in your terraform.tfvars

  # ECR configuration
  rails_repo_name = "rails"
  nginx_repo_name = "nginx"

  # ECS configuration
  ecs_cluster_name           = module.ecs.ecs_cluster_name
  ecs_service_name           = module.ecs.ecs_service_name
  ecs_task_execution_role_arn = module.ecs.ecs_task_execution_role_arn
}