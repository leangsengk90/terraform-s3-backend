output "cloudfront_url" {
  value       = "https://${module.cloudfront-static-site.cloudfront_distribution_domain_name}"
  description = "CloudFront Distribution URL"
}

output "cloudfront_domain_name" {
  value       = module.cloudfront-static-site.cloudfront_distribution_domain_name
  description = "CloudFront Distribution Domain Name"
}

output "cloudfront_distribution_id" {
  value       = module.cloudfront-static-site.cloudfront_distribution_id
  description = "CloudFront Distribution ID"
}
