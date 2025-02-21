output "bation_public_ip" {
  description = "The public IP of the Bastion EC2 instance"
  value = aws_eip.x-eip-ec1-bastion.address
}