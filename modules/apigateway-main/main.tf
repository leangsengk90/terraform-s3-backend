
# Create API Gateway REST API
resource "aws_api_gateway_rest_api" "services_rest_api" {
  name        = "services_gateway_api_${terraform.workspace}"
  description = "services_gateway_api_${terraform.workspace}"
}

# Create API Gateway Resources for each microservice
resource "aws_api_gateway_resource" "services_resource" {
  for_each    = toset(var.services_list)
  rest_api_id = aws_api_gateway_rest_api.services_rest_api.id
  parent_id   = aws_api_gateway_rest_api.services_rest_api.root_resource_id
  path_part   = each.value
}

# Create GET Method for each Resource
resource "aws_api_gateway_method" "services_method" {
  for_each      = aws_api_gateway_resource.services_resource
  rest_api_id   = aws_api_gateway_rest_api.services_rest_api.id
  resource_id   = each.value.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.Content-Type" = true
  }
  depends_on = [aws_api_gateway_resource.services_resource]
}

# Create Integration between API Gateway and Lambda for each service
resource "aws_api_gateway_integration" "services_integration" {
  count                   = length(var.services_list)
  rest_api_id             = aws_api_gateway_rest_api.services_rest_api.id
  resource_id             = aws_api_gateway_resource.services_resource[var.services_list[count.index]].id
  http_method             = "GET"
  credentials             = var.lambda_role_arn
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  request_parameters = {
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
  cache_key_parameters = [
    "method.request.header.Content-Type",
    "integration.request.header.Content-Type",
  ]
  uri = var.lambda_invoke_arn[count.index].invoke_arn
  type = "AWS"
  depends_on = [aws_api_gateway_method.services_method]
}

# Create Method Response for each service
resource "aws_api_gateway_method_response" "services_method_response_200" {
  count       = length(var.services_list)
  rest_api_id = aws_api_gateway_rest_api.services_rest_api.id
  resource_id = aws_api_gateway_resource.services_resource[var.services_list[count.index]].id
  http_method = "GET"
  status_code = "200"
  response_parameters = {
    "method.response.header.Content-Type"              = true
    "method.response.header.Strict-Transport-Security" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [aws_api_gateway_integration.services_integration]
}

# Create Integration Response for each service
resource "aws_api_gateway_integration_response" "services_integration_response_200" {
  count       = length(var.services_list)
  rest_api_id = aws_api_gateway_rest_api.services_rest_api.id
  resource_id = aws_api_gateway_resource.services_resource[var.services_list[count.index]].id
  http_method = "GET"
  status_code = "200"
  response_parameters = {
    "method.response.header.Content-Type"              = "'application/json'"
    "method.response.header.Strict-Transport-Security" = "'max-age=31536000; includeSubdomains; preload'"
  }
  depends_on = [aws_api_gateway_method_response.services_method_response_200]
}

# Create Deployment for the API Gateway
resource "aws_api_gateway_deployment" "services_deployment" {
  depends_on = [
    aws_api_gateway_method_response.services_method_response_200,
    aws_api_gateway_integration_response.services_integration_response_200
  ]
  rest_api_id = aws_api_gateway_rest_api.services_rest_api.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.services_rest_api))
  }  
  lifecycle {
    create_before_destroy = true
  }
}

#Create Stage for the API Gateway
resource "aws_api_gateway_stage" "services_stage" {
  stage_name    = "${terraform.workspace}"
  rest_api_id   = aws_api_gateway_rest_api.services_rest_api.id
  deployment_id = aws_api_gateway_deployment.services_deployment.id
  description   = "${terraform.workspace} Stage"
}


