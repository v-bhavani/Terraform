variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "vm_name" {
  description = "The name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "The machine type"
  type        = string
}

variable "snapshot_name" {
  description = "The name of the snapshot to use for the boot disk"
  type        = string
}

variable "boot_disk_size_gb" {
  description = "The size of the boot disk in GB"
  type        = number
}

variable "disk_type" {
  description = "The type of the disk"
  type        = string
}

variable "network_name" {
  description = "The name of the network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "tags" {
  description = "Tags for the VM"
  type        = list(string)
}

variable "service_account_email" {
  description = "The email of the service account"
  type        = string
}

variable "data_disks" {
  description = "List of data disks to attach"
  type = list(object({
    name        = string
    size        = number
    device_name = string
    type        = string
  }))
}
