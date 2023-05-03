provider "aws" {
  region  = "us-east-1"
}
#
resource "aws_instance" "app_server" {
  ami           = "${var.ami_name}"
  instance_type = "${var.instance_type}"

  tags = {
    Name = "${var.instance_tag}"
  }
}