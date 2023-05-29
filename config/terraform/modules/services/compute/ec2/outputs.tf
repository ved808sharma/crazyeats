output "ec2id" {
  value = aws_instance.ec2.id
  sensitive = false
}