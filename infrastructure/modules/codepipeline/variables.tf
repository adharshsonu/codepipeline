variable "project_name" {
  description = "The name of the project, used for resource naming"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "The AWS Account ID"
  type        = string
}

variable "github_owner" {
  description = "The GitHub organization or username that owns the repository"
  type        = string
}

variable "github_repo" {
  description = "The name of the GitHub repository"
  type        = string
}

variable "github_branch" {
  description = "The branch of the GitHub repository to monitor"
  type        = string
  default     = "main"
}

variable "github_oauth_token" {
  description = "GitHub OAuth token for CodePipeline access"
  type        = string
  sensitive   = true
}

variable "rails_repo_name" {
  description = "The name of the ECR repository for the Rails image"
  type        = string
}

variable "nginx_repo_name" {
  description = "The name of the ECR repository for the Nginx image"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster to deploy to"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service to deploy to"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}