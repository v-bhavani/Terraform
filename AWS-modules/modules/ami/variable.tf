variable "instance_id" {
  description = "The ID of the instance to create an AMI from"
  type        = string
}

variable "ami_name" {
  description = "The name of the AMI to create"
  type        = string
}

variable "ami_description" {
  description = "The description of the AMI to create"
  type        = string
}
