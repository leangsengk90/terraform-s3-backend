
# DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_state_locks" {
  name           = "terraform-state-locks-${terraform.workspace}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-state-locks-${terraform.workspace}"
    Environment = "${terraform.workspace}"
    Purpose     = "terraform-state-locks-${terraform.workspace}"
  }
}