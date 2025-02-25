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

variable "service_account_email" {
  description = "The service account email"
  type        = string
}

variable "tags" {
  description = "Network tags"
  type        = list(string)
}
