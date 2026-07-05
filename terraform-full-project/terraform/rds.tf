resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!@#%^*()-_=+"
}

resource "aws_secretsmanager_secret" "db" {
  name                    = "${local.name_prefix}/database/password"
  recovery_window_in_days = 7

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-secret"
  })
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
    engine   = "mysql"
    host     = ""
  })
}

resource "aws_db_subnet_group" "main" {
  name       = "${local.name_prefix}-db-subnet-group"
  subnet_ids = local.private_db_subnet_ids

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-subnet-group"
  })
}

resource "aws_db_parameter_group" "mysql" {
  name   = "${local.name_prefix}-mysql8"
  family = "mysql8.0"

  parameter {
    name  = "binlog_format"
    value = "ROW"
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-parameter-group"
  })
}

resource "aws_db_instance" "main" {
  identifier                      = "${local.name_prefix}-mysql"
  allocated_storage               = 20
  storage_type                    = "gp3"
  storage_encrypted               = true
  engine                          = "mysql"
  engine_version                  = "8.0.35"
  instance_class                  = "db.t3.micro"
  db_name                         = var.db_name
  username                        = var.db_username
  password                        = random_password.db.result
  parameter_group_name            = aws_db_parameter_group.mysql.name
  db_subnet_group_name            = aws_db_subnet_group.main.name
  vpc_security_group_ids          = [aws_security_group.database.id]
  publicly_accessible             = false
  backup_retention_period         = 7
  backup_window                   = "03:00-04:00"
  maintenance_window              = "sun:04:00-sun:05:00"
  skip_final_snapshot             = false
  final_snapshot_identifier       = "${local.name_prefix}-mysql-final-snapshot"
  deletion_protection             = true
  apply_immediately               = false
  monitoring_interval             = 60
  monitoring_role_arn             = aws_iam_role.rds_monitoring.arn
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-mysql"
  })
}

resource "aws_iam_role" "rds_monitoring" {
  name = "${local.name_prefix}-rds-monitoring-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rds-monitoring-role"
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
