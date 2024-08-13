variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_name" {
  description = "The name of the existing VM"
  type        = string
}

variable "disk_size_gb" {
  description = "Size of the disk in GB"
  type        = number
}

variable "disk_name" {
  description = "Name of the new disk"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_type" {
  description = "The type of storage account"
  type        = string
  default     = "Standard_LRS"
}
