resource "aws_ami_from_instance" "this" {
  name               = var.ami_name
  description        = var.ami_description
  source_instance_id = var.instance_id
  tags = {
    Name = var.ami_name
  }
}
