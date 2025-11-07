output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.static_site.bucket_regional_domain_name
}

output "static_site_id" {
  value     = aws_s3_bucket.static_site.id
}

output "static_site_arn" {
  value     = aws_s3_bucket.static_site.arn
}

