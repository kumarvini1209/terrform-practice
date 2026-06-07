output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_ec2_id" {
  value = aws_instance.private_server.id
}

output "private_ec2_private_ip" {
  value = aws_instance.private_server.private_ip
}