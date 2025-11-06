# Archive each service directory into a zip file
data "archive_file" "services_zip" {
  count       = length(var.services_list)
  type        = "zip"
  source_dir  = "${path.module}/../../services/${var.services_list[count.index]}"
  output_path = "${path.module}/../../services/zip/${terraform.workspace}/${var.services_list[count.index]}.zip"
}

# Create a Lambda function for each service
resource "aws_lambda_function" "services_function" {
  count            = length(var.services_list)
  filename         = data.archive_file.services_zip[count.index].output_path
  function_name    = "services_function_${var.services_list[count.index]}_${terraform.workspace}"
  role             = var.lambda_role_arn
  handler          = var.lambda_handler
  source_code_hash = data.archive_file.services_zip[count.index].output_base64sha256
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
}
