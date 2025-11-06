output "services_function_invoke_arn" {
  value = [
    for lambda in aws_lambda_function.services_function : {
      invoke_arn = lambda.invoke_arn
    }
  ]
  description = "List of Lambda function invoke ARNs"
}
