resource "aws_default_vpc" "mozzy_craft_vpc" {
  tags = {
    project = "mozzy_craft"
  }
}

resource "aws_security_group" "mozzy_craft_security_group" {
  name        = "mozzy_craft_security_group"
  vpc_id      = aws_default_vpc.mozzy_craft_vpc.id
  description = "mozzy craft security group"
  tags = {
    project = "mozzy_craft"
  }

  ingress {
    description = "SSH for Mozzy Craft"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = var.ingress_cidr_block
  }

  ingress {
    description = "Allow Minecraft connections"
    protocol = "tcp"
    from_port = 25565
    to_port = 25565
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
