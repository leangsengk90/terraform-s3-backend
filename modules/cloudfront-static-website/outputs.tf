output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "cdn_arn" {
  value       = aws_cloudfront_distribution.cdn.arn
}