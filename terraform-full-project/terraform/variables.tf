variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "owner" {
  description = "Owner tag value"
  type        = string
  default     = "devops-team"
}

variable "application_name" {
  description = "Application name tag value"
  type        = string
  default     = "fullstack-app"
}

variable "project_name" {
  description = "Project name tag value"
  type        = string
  default     = "terraform-aws-production"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "office_cidr" {
  description = "Office/public IP CIDR allowed for SSH to bastion"
  type        = string
  default     = "203.0.113.0/24"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "prod-keypair"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "AMI ID for Amazon Linux 2023"
  type        = string
  default     = "ami-0f5ee92e2d63afcfa"
}

variable "bastion_ssh_port" {
  description = "SSH port for bastion security group"
  type        = number
  default     = 22
}

variable "frontend_port" {
  description = "Frontend application port"
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Backend application port"
  type        = number
  default     = 8080
}

variable "alb_certificate_arn" {
  description = "ARN of ACM certificate for ALB HTTPS listener"
  type        = string
  default     = ""
}

variable "github_repo_url" {
  description = "Repository URL for deployment"
  type        = string
  default     = "https://github.com/example/production-app.git"
}

variable "github_repo_branch" {
  description = "Repository branch for deployment"
  type        = string
  default     = "main"
}
