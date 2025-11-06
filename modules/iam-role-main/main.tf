# IAM Role for Lambda and API Gateway
resource "aws_iam_role" "lambda_assume_role" {
  name               = "lambda_assume_role_${terraform.workspace}"
  assume_role_policy = file("${path.module}/policies/lambda-assume-role.json")
}

# Lambda Invocation Policy
resource "aws_iam_role_policy" "lambda_invocation_policy" {
  name   = "lambda_invocation_policy_${terraform.workspace}"
  role   = aws_iam_role.lambda_assume_role.id
  policy = file("${path.module}/policies/lambda-invocation-policy.json")
}

# Attach AWSLambdaBasicExecutionRole policy to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_assume_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_assume_role.name
}

