variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
}

variable "volume_size" {
  description = "Size of EBS volumes"
  type        = number
}

variable "volume_type" {
  description = "Type of EBS volume"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}
