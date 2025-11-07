
module "s3-static-site" {
    source       = "../modules/s3-static-website"
    website_path = var.website_path
    mime_types   = var.mime_types
}

module "cloudfront-static-site" {
    source = "../modules/cloudfront-static-website"
    bucket_regional_domain_name = module.s3-static-site.bucket_regional_domain_name
    static_site_id = module.s3-static-site.static_site_id
}

module "iam-role-static-website" {
    source = "../modules/iam-role-static-website"
    static_site_arn = module.s3-static-site.static_site_arn
    static_site_id  = module.s3-static-site.static_site_id
    cdn_arn         = module.cloudfront-static-site.cdn_arn
}