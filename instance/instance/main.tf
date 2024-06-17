provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  key_name               = var.key_name

  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }

  tags = {
    Name = "MyEC2Instance"
    Project = "test"
    Mail = "irfana.j@basiscloudsolutions.com"
  }
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
