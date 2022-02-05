data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "test-terraform-us-east-1"
    key    = "test-Terraform-mutable/vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}