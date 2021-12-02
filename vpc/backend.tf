terraform {
    backend "s3" {
        bucket= "test-terraform-us-east-1"
        key= "test-Terraform-mutable/vpc/dev/terraform.tfstate"
        region= "us-east-1"
    }
}

provider "aws" {
    region= "us-east-1"
}