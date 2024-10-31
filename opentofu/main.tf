# main.tf

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.48.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}

provider "hcloud" {
  token = var.hetzner_token
}

provider "aws" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}
