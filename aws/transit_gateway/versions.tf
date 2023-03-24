terraform {
  required_version = ">= 1.1.9"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

provider "aws" {
  region = var.location
}

