terraform {
  backend "s3" {
    bucket         = "cv-challenge02-terraform-state-backend"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cv-challenge02-terraform-locks"
    encrypt        = true
  }
}
