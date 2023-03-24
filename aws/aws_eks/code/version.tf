
terraform {
  required_version = ">= 1.0"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.53.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.4"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.4.3"
    }
  }
}

# provider "tls"{}

provider "aws" {
  region = var.location
}



