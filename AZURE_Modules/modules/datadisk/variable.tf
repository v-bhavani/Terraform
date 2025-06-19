variable "disk_name" {
  description = "The name of the data disk"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the disk will be created"
  type        = string
}

variable "storage_account_type" {
  description = "The type of storage to use for the disk"
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "The size of the disk in GB"
  type        = number
  default     = 10
}

variable "vm_id" {
  description = "The ID of the VM to attach the disk to"
  type        = string
}

variable "lun" {
  description = "The Logical Unit Number of the disk"
  type        = number
  default     = 0
}

variable "caching" {
  description = "The caching mode for the disk"
  type        = string
  default     = "ReadWrite"
}

variable "tags" {
  description = "Tags to apply to the disk"
  type        = map(string)
  default     = {}
}