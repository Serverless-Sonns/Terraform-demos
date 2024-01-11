output "public-ip" {
  value = aws_instance.terra_instance.public_dns
}