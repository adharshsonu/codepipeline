output "rds_endpoint" {
  description = "The hostname of the RDS instance without port"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.this.port
}