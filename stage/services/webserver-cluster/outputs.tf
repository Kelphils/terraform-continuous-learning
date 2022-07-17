
#  replace printing the public IP address of the instance to the console with the alb load balancer name
output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}
