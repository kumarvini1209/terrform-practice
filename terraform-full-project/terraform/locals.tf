locals {
  name_prefix = "${var.environment}-${var.application_name}"

  common_tags = {
    Environment = var.environment
    Owner       = var.owner
    Application = var.application_name
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }

  public_subnet_ids      = aws_subnet.public[*].id
  private_app_subnet_ids = aws_subnet.private_app[*].id
  private_db_subnet_ids  = aws_subnet.private_db[*].id
}
