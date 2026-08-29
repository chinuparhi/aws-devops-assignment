resource "aws_cloudwatch_dashboard" "infrastructure" {
  dashboard_name = "${var.project_name}-infrastructure"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "ECS CPU Utilization"

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.staging.name
            ]
          ]

          period = 300
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "ECS Memory Utilization"

          metrics = [
            [
              "AWS/ECS",
              "MemoryUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.staging.name
            ]
          ]

          period = 300
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title = "RDS CPU"

          metrics = [
            [
              "AWS/RDS",
              "CPUUtilization",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]

          period = 300
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title = "RDS Free Storage"

          metrics = [
            [
              "AWS/RDS",
              "FreeStorageSpace",
              "DBInstanceIdentifier",
              aws_db_instance.postgres.identifier
            ]
          ]

          period = 300
          stat   = "Average"
          region = var.aws_region
        }
      }
    ]
  })
}

resource "aws_cloudwatch_dashboard" "application" {
  dashboard_name = "${var.project_name}-application"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "Request Count"

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              aws_lb.main.arn_suffix
            ]
          ]

          period = 300
          stat   = "Sum"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "HTTP 5XX Errors"

          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_Target_5XX_Count",
              "LoadBalancer",
              aws_lb.main.arn_suffix
            ]
          ]

          period = 300
          stat   = "Sum"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title = "Application Latency"

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              aws_lb.main.arn_suffix
            ]
          ]

          period = 300
          stat   = "Average"
          region = var.aws_region
        }
      }
    ]
  })
}