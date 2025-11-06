
# Invoke the Lambda module
module "lambda" {
  source           = "../modules/lambda-main"
  services_list    = var.services_list
  lambda_role_arn  = module.iam_role.role_arn
  lambda_handler   = var.lambda_handler
  lambda_runtime   = var.lambda_runtime
  lambda_timeout   = var.lambda_timeout
}

module "iam_role" {
  source = "../modules/iam-role-main"
}

module "apigateway" {
  source            = "../modules/apigateway-main"
  services_list     = var.services_list
  lambda_role_arn   = module.iam_role.role_arn
  lambda_invoke_arn = module.lambda.services_function_invoke_arn
}