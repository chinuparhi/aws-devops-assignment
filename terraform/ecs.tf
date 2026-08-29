resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enhanced"
  }
}

resource "aws_ecs_task_definition" "staging" {
  family                   = "${var.project_name}-staging"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.ecs_cpu
  memory = var.ecs_memory

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.app_image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "ENVIRONMENT"
          value = "staging"
        },

        {
          name  = "PORT"
          value = tostring(var.container_port)
        }
      ]

      secrets = [
        {
          name      = "DATABASE_SECRET"
          valueFrom = aws_secretsmanager_secret.db.arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.staging.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "production" {
  family                   = "${var.project_name}-production"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.ecs_cpu
  memory = var.ecs_memory

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.app_image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "ENVIRONMENT"
          value = "production"
        },

        {
          name  = "PORT"
          value = tostring(var.container_port)
        }
      ]

      secrets = [
        {
          name      = "DATABASE_SECRET"
          valueFrom = aws_secretsmanager_secret.db.arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.production.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "staging" {
  name            = "${var.project_name}-staging"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.staging.arn

  desired_count = var.staging_desired_count

  launch_type = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.staging.arn
    container_name   = "app"
    container_port   = var.container_port
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution
  ]
}

resource "aws_ecs_service" "production" {
  name            = "${var.project_name}-production"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.production.arn

  desired_count = var.production_desired_count

  launch_type = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.production.arn
    container_name   = "app"
    container_port   = var.container_port
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution
  ]
}