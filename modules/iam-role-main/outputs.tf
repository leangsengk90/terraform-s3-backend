output "role_arn" {
  value       = aws_iam_role.lambda_assume_role.arn
  description = "ARN of the IAM role"
}

output "role_name" {
  value       = aws_iam_role.lambda_assume_role.name
  description = "Name of the IAM role"
}

output "role_id" {
  value       = aws_iam_role.lambda_assume_role.id
  description = "ID of the IAM role"
}

output "role_unique_id" {
  value       = aws_iam_role.lambda_assume_role.unique_id
  description = "Unique ID of the IAM role"
}
