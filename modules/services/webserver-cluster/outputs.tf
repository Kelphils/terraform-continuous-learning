
#  replace printing the public IP address of the instance to the console with the alb load balancer name
output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}

output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "The name of the Auto Scaling Group"
}

# output of security group id to be referenced in the main.tf file 
# of the staging or prod environment in you wish to add another rule
output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the Security Group attached to the load balancer"
}
