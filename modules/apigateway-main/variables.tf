variable "services_list" {
    type = list(string)
}

variable "lambda_role_arn" {
    type = string
}

variable "lambda_invoke_arn" {
    type = list(object({
        invoke_arn = string
    }))
}