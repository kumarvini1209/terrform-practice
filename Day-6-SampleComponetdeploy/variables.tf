variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_az1_cidr" {
  type = string
}

variable "public_subnet_az2_cidr" {
  type = string
}

variable "private_subnet_az1_cidr" {
  type = string
}

variable "private_subnet_az2_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "my_ip" {
  description = "Your public IP for SSH access"
  type        = string
}