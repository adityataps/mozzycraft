resource "aws_instance" "mozzy_craft_ec2" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t3.medium"

  hibernation = true
  key_name    = aws_key_pair.ec2_key.id
  security_groups = [aws_security_group.mozzy_craft_security_group.id]
  tags = {
    project = "mozzy_craft"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y java-17-amazon-corretto
              mkdir -p /home/ec2-user/minecraft
              cd /home/ec2-user/minecraft
              wget https://piston-data.mojang.com/v1/objects/145ff0858209bcfc164859ba735d4199aafa1eea/server.jar
              echo "eula=true" > eula.txt
              java -Xmx4G -Xms4G -jar server.jar nogui
              EOF

}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-key"
  public_key = var.ssh_public_key
}
