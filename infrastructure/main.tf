terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
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

# ECS Module: ECS cluster, task, service with ALB and ECR images
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
}
