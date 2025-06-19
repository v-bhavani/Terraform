variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the VM will be created"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine (if not using SSH)"
  type        = string
  sensitive   = true
  default     = null
}

variable "ssh_keys" {
  description = "A list of SSH public keys to configure for the admin user"
  type        = list(string)
  default     = []
}

variable "os_disk_type" {
  description = "The type of OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "The publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "The offer of the VM image"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "The SKU of the VM image"
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "The version of the VM image"
  type        = string
  default     = "latest"
}

variable "subnet_id" {
  description = "The ID of the subnet where the VM will be deployed"
  type        = string
}

variable "create_public_ip" {
  description = "Whether to create a public IP for the VM"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the VM resources"
  type        = map(string)
  default     = {}
}