output "runner_public_ip" {
  description = "The public IP of the Runner EC2 instance"
  value = aws_eip.x-eip-ec1-runner.address
}

output "alb" {
  description = "Domain name of Front-End ALB"
  value = aws_lb.x-alb-ec1.dns_name
}