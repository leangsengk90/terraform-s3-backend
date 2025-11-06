output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_id" {
  value       = aws_s3_bucket.terraform_state.id
  description = "The ID of the S3 bucket"
}
