# aws region
aws_region = "us-east-1"

# Services to deploy
services_list = ["api1", "api3"]

# Lambda configurations
lambda_handler = "main.lambda_handler"
lambda_runtime = "python3.12"
lambda_timeout = "600"

website_path = "../services/static-website"
mime_types = {
  "html" = "text/html"
  "css"  = "text/css"
  "js"   = "application/javascript"
  "png"  = "image/png"
  "jpg"  = "image/jpeg"
  "jpeg" = "image/jpeg"
  "gif"  = "image/gif"
  "svg"  = "image/svg+xml"
  "ico"  = "image/x-icon"
}
