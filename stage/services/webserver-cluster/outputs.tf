# Alb dns name to check after resources have been created to ensure 
# they are running and ready to use.
output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}
