variable "instance_id" {
  description = "The ID of the instance to attach the volume to"
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
