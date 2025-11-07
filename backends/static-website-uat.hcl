bucket         = "devops-up-state-uat"
key            = "static-website/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-state-locks-uat"