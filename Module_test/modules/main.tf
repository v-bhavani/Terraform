provider "aws" {
  region = var.aws_region
}

# Server 1 - With 2 Volumes
module "server1" {
  source            = "./modules/ec2-instance"
  instance_type     = var.instance_type
  ami_id           = var.ami_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  key_name          = var.key_name
}

module "server1_volumes" {
  source            = "./modules/ebs-volume"
  instance_id       = module.server1.instance_id
  volume_count      = 2
  volume_size       = var.volume_size
  volume_type       = var.volume_type
  availability_zone = var.availability_zone
}

# Server 2 - With 3 Volumes
module "server2" {
  source            = "./modules/ec2-instance"
  instance_type     = var.instance_type
  ami_id            = var.ami_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  key_name          = var.key_name
}

module "server2_volumes" {
  source            = "./modules/ebs-volume"
  instance_id       = module.server2.instance_id
  volume_count      = 3
  volume_size       = var.volume_size
  volume_type       = var.volume_type
  availability_zone = var.availability_zone
}
