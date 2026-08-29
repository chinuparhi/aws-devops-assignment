resource "aws_cloudwatch_log_group" "staging" {
  name              = "/ecs/${var.project_name}/staging"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "production" {
  name              = "/ecs/${var.project_name}/production"
  retention_in_days = 14
}