provider "aws" {
  region = var.region
}

resource "aws_eip" "my_static_ip" {
  instance = var.instance_id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.my_static_ip.id
}
