terraform {
  backend "s3" {
    bucket         = "terraform-state-prod-aws-demo"
    key            = "production/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks-prod"
    encrypt        = true
  }
}

resource "aws_instance" "backend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_app[1].id
  vpc_security_group_ids      = [aws_security_group.backend.id, aws_security_group.app_ssh.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = aws_key_pair.main.key_name

  user_data = file("${path.module}/user-data/backend.sh")

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    encrypted             = true
    delete_on_termination = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-backend"
  })
}
