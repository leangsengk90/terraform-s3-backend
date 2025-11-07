
# Create IAM Role for CloudFront to access S3 bucket
resource "aws_iam_role" "cloudfront_access_role" {
  name = "cloudfront-access-role-${terraform.workspace}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create IAM Policy to allow S3 read access
resource "aws_iam_policy" "s3_read_policy" {
  name        = "s3-read-policy-${terraform.workspace}"
  description = "Allow CloudFront to read objects from S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${var.static_site_arn}/*"
      }
    ]
  })
}

# Attach IAM Policy to CloudFront IAM Role
resource "aws_iam_role_policy_attachment" "attach_read_policy" {
  role       = aws_iam_role.cloudfront_access_role.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

# Create S3 Bucket Policy to allow CloudFront access via OAC
resource "aws_s3_bucket_policy" "oac_policy" {
  bucket = var.static_site_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = ["s3:GetObject"],
        Resource = "${var.static_site_arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "${var.cdn_arn}"
          }
        }
      }
    ]
  })
}
