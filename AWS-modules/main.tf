provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-bcs"
    key            = "tf/terraformstart.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
module "ec2_instance" {
  source           = "./modules/ec2-instance"
  instance_type    = var.instance_type
  ami_id           = var.ami_id
  subnet_id        = var.subnet_id
  security_group_id = var.security_group_id
  key_name         = var.key_name
}

module "ebs_volume" {
  source        = "./modules/ebs-volume"
  instance_id   = module.ec2_instance.instance_id
  volume_size   = var.volume_size
  volume_type   = var.volume_type
  availability_zone = var.availability_zone
}

module "ami" {
  source        = "./modules/ami"
  instance_id   = module.ec2_instance.instance_id
  ami_name      = var.ami_name
  ami_description = var.ami_description
}
