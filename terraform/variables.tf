variable "aws_access_key_id" {}

variable "aws_secret_access_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "ssh_public_key" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFh3uGeCPs0OUWshUNDBJ/z0zqjONHN7NBjoNN4XNNnQ aditya.taps@gmail.com"
}

variable "ingress_cidr_block" {
  default = ["18.206.107.24/29"]
}

variable "domain_name" {
  default = "tapshalkar.xyz"
}

variable "route_53_zone_id" {
  default = "Z09909302GN2Y7S27BVHH"
}
