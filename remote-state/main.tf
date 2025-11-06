
module "aws_s3_bucket" {
  source = "../modules/s3-remote-state"
}

module "aws_dynamodb_table" {
  source = "../modules/dynamodb-remote-state"
}