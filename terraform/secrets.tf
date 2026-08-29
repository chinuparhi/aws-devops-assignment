resource "random_password" "db" {
  length = 24

  special = true
}

resource "aws_secretsmanager_secret" "db" {
  name = "${var.project_name}/database"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
    database = var.db_name
  })
}