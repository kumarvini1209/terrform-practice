resource "aws_launch_template" "bastion" {
  name_prefix   = "${local.name_prefix}-bastion-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.bastion.id, aws_security_group.app_ssh.id]
  }

  user_data = base64encode(file("${path.module}/user-data/bastion.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-bastion"
    })
  }
}

resource "aws_launch_template" "frontend" {
  name_prefix   = "${local.name_prefix}-frontend-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.frontend.id, aws_security_group.app_ssh.id]
  }

  user_data = base64encode(file("${path.module}/user-data/frontend.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-frontend"
    })
  }
}

resource "aws_launch_template" "backend" {
  name_prefix   = "${local.name_prefix}-backend-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.backend.id, aws_security_group.app_ssh.id]
  }

  user_data = base64encode(file("${path.module}/user-data/backend.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-backend"
    })
  }
}
