variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "zone" {
  description = "The zone where resources will be created"
  type        = string
}

variable "disk_name" {
  description = "The name of the new disk to be created"
  type        = string
}

variable "disk_type" {
  description = "The name of the new disk to be created"
  type        = string
}

variable "disk_size" {
  description = "The size of the new disk in GB"
  type        = number
}

variable "vm_name" {
  description = "The name of the existing VM to attach the disk to"
  type        = string
}

variable "environment" {
  description = "The environment label for the disk"
  type        = string
  default     = "dev"
}

variable "device_name" {
  description = "The name of the new disk to be created"
  type        = string
}