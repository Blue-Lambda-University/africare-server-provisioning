output "public_ip" {
  value = aws_instance.dev_ec2.public_ip
}

output "public_key_path" {
  value = aws_key_pair.ec2_key.public_key
}
