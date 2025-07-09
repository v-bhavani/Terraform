variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "vms" {
  description = "List of VMs with disks"
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
    disks        = list(object({
      name    = string
      size_gb = number
    }))
  }))
}

variable "network_name" {
  description = "The network name"
  type        = string
}

variable "subnet_name" {
  description = "The subnet name"
  type        = string
}

variable "zone" {
  description = "The zone where the resources will be created"
  type        = string
}


variable "tags" {
  description = "Tags to assign to the VMs"
  type        = list(string)
  default     = ["web", "production"] # Set a default value to avoid errors
}

