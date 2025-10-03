variable "project_name" {}

variable "vpc_id" {}

variable "private_subnets" {
  type = list(string)
}

variable "rds_username" {}

variable "rds_password" {
  sensitive = true
}

variable "rds_db_name" {}

variable "rds_instance_class" {
  default = "db.t3.micro"
}

variable "rds_port" {
  description = "Port on which RDS listens"
  type        = string
  default     = "5432"
}