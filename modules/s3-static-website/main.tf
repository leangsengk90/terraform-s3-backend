
# Create S3 bucket for static website hosting
resource "aws_s3_bucket" "static_site" {
  bucket = "up-static-site-${terraform.workspace}"
}

# Enable static website hosting
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.static_site.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Configure the bucket for website hosting
resource "aws_s3_object" "website_files" {
  for_each     = fileset("${var.website_path}", "**")
  bucket       = aws_s3_bucket.static_site.id
  key          = each.value
  source       = "${var.website_path}/${each.value}"
  etag         = filemd5("${var.website_path}/${each.value}")
  content_type = lookup(var.mime_types, regex(".*\\.(.*)$", each.value)[0], "text/plain")
}