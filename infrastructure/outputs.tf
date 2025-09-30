output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.ecs.alb_dns_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  description = "Name of the ECS Service"
  value       = module.ecs.ecs_service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS Task Definition"
  value       = module.ecs.ecs_task_definition_arn
}

output "rds_endpoint" {
  description = "RDS endpoint to connect to the database"
  value       = module.rds.rds_endpoint
}