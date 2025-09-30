project_name         = "ror-app"
aws_region           = "ap-south-1"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

rds_username         = "roruser"
rds_password         = "Pulsarns200"
rds_db_name          = "rorappdb"
rds_instance_class   = "db.t3.micro"

ecr_ror_image        = "612565767098.dkr.ecr.ap-south-1.amazonaws.com/rails:latest"
ecr_nginx_image      = "612565767098.dkr.ecr.ap-south-1.amazonaws.com/nginx:latest"
