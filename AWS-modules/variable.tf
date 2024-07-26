variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the instance"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
}

variable "volume_type" {
  description = "The type of the EBS volume"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone where the EBS volume should be created"
  type        = string
}

#=======================

variable "ami_name" {
  description = "The name of the AMI to create"
  type        = string
}

variable "ami_description" {
  description = "The description of the AMI to create"
  type        = string
}