terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.0.0"
    }
  }


backend "s3" {
   bucket = "upgradterraformbucket"
   key = "states/terraform.tfstate"
   region = "us-east-1"
}
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}