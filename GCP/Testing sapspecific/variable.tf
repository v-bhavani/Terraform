variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "network_name" {
  description = "The name of the network to use"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnetwork to use"
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account to use for VMs"
  type        = string
}

variable "snapshot_name" {
  description = "The name of the snapshot to use for VM images"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = list(string)
}

variable "vm_name" {
  description = "The name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "zone" {
  description = "Zone where the VM will be deployed"
  type        = string
}

variable "disks" {
  description = "List of disks to be attached to the VM"
  type = list(object({
    name    = string
    size_gb = number
    type    = string
  }))
}
