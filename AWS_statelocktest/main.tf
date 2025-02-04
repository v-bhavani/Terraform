provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-bcs"
    key            = "tf/terraformstart.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.sg_name}"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from anywhere (Modify as needed)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (Change based on region)
  instance_type          = "t2.micro"  # Free tier eligible
  key_name               = "${var.keypair}"  # Replace with your existing key pair
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    "Owner" = "${var.Name}"
    "var.mail" = "${var.mailid}"
    "var.purpose" = "${var.purpose}"
  }
}

output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
