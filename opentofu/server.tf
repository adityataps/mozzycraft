# server.tf

locals {
  hetzner_server_name     = "mozzycraft_server"
  hetzner_server_type     = "CPX31"
  hetzner_server_location = "ash"
  hetzner_server_image    = "ubuntu-24.04"

  hetzner_volume_name = "mozzycraft_volume"
  hetzner_volume_size = 50
}

resource "tls_private_key" "server_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "server_private_key" {
  value     = tls_private_key.server_key.private_key_openssh
  sensitive = true
}

resource "hcloud_ssh_key" "server_key" {
  name       = "Terraform Example"
  public_key = tls_private_key.server_key.public_key_openssh
}

resource "hcloud_server" "server" {
  name        = local.hetzner_server_name
  server_type = local.hetzner_server_type
  image       = local.hetzner_server_image
  location    = local.hetzner_server_location
  ssh_keys    = [hcloud_ssh_key.server_key.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_volume" "server_volume" {
  name      = local.hetzner_volume_name
  size      = local.hetzner_volume_size
  server_id = hcloud_server.server.id
  automount = true
  format    = "ext4"
}
