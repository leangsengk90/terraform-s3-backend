output "aws_s3_bucket_name" {
  value       = module.aws_s3_bucket
  description = "The name of the S3 bucket for Terraform state"
}

output "aws_dynamodb_table_name" {
  value       = module.aws_dynamodb_table
  description = "The name of the DynamoDB table for state locking"
}