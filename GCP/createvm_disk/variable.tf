variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "vms" {
  description = "A list of VM configurations"
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
    disks        = list(object({
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

variable "snapshot_name" {
  description = "The name of the snapshot to use for the boot disk"
  type        = string
}

variable "zone" {
  description = "The name of the snapshot to use for the boot disk"
  type        = string
}

variable "service_account_email" {
  description = "The service account email to attach to the VMs"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the VMs"
  type        = list(string)  # Change to list(string) if you use a list for tags
}
