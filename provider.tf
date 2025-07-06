terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "YOUR_BUCKET_NAME"   
    key            = "terraform/state/ha-webapp.tfstate"
    region         = "us-east-1"  
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
