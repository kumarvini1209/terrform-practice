provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
      Application = var.application_name
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}
