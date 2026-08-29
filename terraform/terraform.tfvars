aws_region   = "ap-south-1"
project_name = "devops-assignment"
environment  = "staging"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

container_port = 5000

ecs_cpu    = 256
ecs_memory = 512

staging_desired_count    = 1
production_desired_count = 1

db_name              = "appdb"
db_username          = "appadmin"
db_instance_class    = "db.t4g.micro"
db_allocated_storage = 20