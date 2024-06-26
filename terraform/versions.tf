terraform {
  required_version = ">= 1.8.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  cloud {
    organization = "adi-sandbox"
    workspaces {
      name = "mozzycreek"
    }
  }
}
