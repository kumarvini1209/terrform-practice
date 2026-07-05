# Production AWS Terraform Architecture

This project provisions a production-grade AWS environment in `ap-south-1` with:

- VPC with public, private app, and private database subnets
- Internet gateway and NAT gateway
- Application Load Balancer with HTTPS listener
- Bastion host for secure administration
- Frontend and backend EC2 tiers with Auto Scaling Groups
- Amazon RDS MySQL in private subnets
- Secrets Manager integration for database credentials
- IAM roles and instance profiles for SSM/CloudWatch access

## Prerequisites

- Terraform `>= 1.8`
- AWS CLI configured with appropriate credentials
- An ACM certificate ARN for the ALB HTTPS listener
- A public SSH key at `keys/prod-keypair.pub`

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Update values for your environment
3. Run:

```bash
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Notes

- The backend is configured for S3 + DynamoDB locking.
- Database credentials are stored in Secrets Manager.
- The project uses tags for ownership, environment, application, and project tracking.
