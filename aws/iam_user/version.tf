terraform {
  required_version = ">= 0.13"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.13.0"
    }
  }
}
provider "aws" {
  region = var.region
}