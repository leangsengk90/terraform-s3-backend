# AWS Region Variable
variable "aws_region" {
  type    = string
}

variable "website_path" {
  type = string
}

variable "mime_types" {
  type = map(string)
}