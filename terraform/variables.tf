variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "devops-assignment"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "staging"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

variable "container_port" {
  description = "Application container port"
  type        = number
  default     = 5000
}

variable "ecs_cpu" {
  description = "ECS task CPU"
  type        = number
  default     = 256
}

variable "ecs_memory" {
  description = "ECS task memory"
  type        = number
  default     = 512
}

variable "staging_desired_count" {
  description = "Number of staging tasks"
  type        = number
  default     = 1
}

variable "production_desired_count" {
  description = "Number of production tasks"
  type        = number
  default     = 1
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "appadmin"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "RDS storage in GB"
  type        = number
  default     = 20
}

variable "app_image" {
  description = "Docker image for ECS"
  type        = string
  default     = "public.ecr.aws/docker/library/python:3.13-slim"
}