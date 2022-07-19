output "aws_db_instance_arn" {
  value       = aws_db_instance.example.arn
  description = "The ARN of the DynamoDB table"
}

output "aws_db_instance_name" {
  value       = aws_db_instance.example.name
  description = "The ARN of the DynamoDB table"
}

output "address" {
  value       = aws_db_instance.example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The port the database is listening on"
}
