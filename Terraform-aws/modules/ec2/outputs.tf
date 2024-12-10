output "ec2_ids" {
  value = aws_instance.web[*].id
}

output "ec2_ips" {
  value = aws_instance.web[*].public_ip
}

