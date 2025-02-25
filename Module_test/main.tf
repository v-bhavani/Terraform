provider "aws" {
  region = var.aws_region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "server1" {
  source            = "./Module_test/ec2-instance"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  key_name         = var.key_name
  instance_name    = "server1"
}

module "server1_volumes" {
  source           = "./Module_test/ebs-volume"
  instance_id      = module.server1.instance_id
  volume_size      = var.volume_size
  volume_type      = var.volume_type
  availability_zone = var.availability_zone
  volume_count     = 2
  instance_name    = "server1"
}

module "server2" {
  source            = "./Module_test/ec2-instance"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  key_name         = var.key_name
  instance_name    = "server2"
}

module "server2_volumes" {
  source           = "./Module_test/ebs-volume"
  instance_id      = module.server2.instance_id
  volume_size      = var.volume_size
  volume_type      = var.volume_type
  availability_zone = var.availability_zone
  volume_count     = 3
  instance_name    = "server2"
}
