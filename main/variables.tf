# AWS Region Variable
variable "aws_region" {
  type    = string
}

variable "services_list" {
  type = list(string)
}

variable "lambda_handler" {
  type = string
}

variable "lambda_runtime" {
  type = string
} 

variable "lambda_timeout" {
  type = string
}