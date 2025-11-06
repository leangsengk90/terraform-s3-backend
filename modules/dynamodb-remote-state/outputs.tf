output "table_name" {
  value       = aws_dynamodb_table.terraform_state_locks.name
  description = "The name of the DynamoDB table"
}

output "table_arn" {
  value       = aws_dynamodb_table.terraform_state_locks.arn
  description = "The ARN of the DynamoDB table"
}

output "table_id" {
  value       = aws_dynamodb_table.terraform_state_locks.id
  description = "The ID of the DynamoDB table"
}
