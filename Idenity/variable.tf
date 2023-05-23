variable "data_disk" {
  type = map(object({
    vm_name      = string
    disk_name    = string
    disk_size = number
    lun = number
  }))
}

variable "subscription_id" {
  type    = string
  default = ""
}

variable "tenant_id" {
  type    = string
  default = ""
}
variable "vm_names" {
  description = "List of names for the virtual machines"
  type        = list(string)
}

variable "username" {
  description = "List of usernames for the virtual machines"
  type        = string
}

variable "password" {
  description = "List of passwords for the virtual machines"
  type        = string
}

/*variable "resource_group_id" {
  description = "ID of the existing resource group"
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the existing virtual network"
  type        = string
}*/
variable "resourcedetails" {
  description = "name of resource"
  type        = string
}
variable "subnetname" {
  description = "name of resource"
  type        = string
}
variable "vnetname" {
  description = "name of resource"
  type        = string
}
variable "RG" {
  description = "name of resource"
  type        = string
}
variable "location" {
  description = "name of resource"
  type        = string
}
variable "ip" {
  description = "name of resource"
  type        = list(string)
}
variable "vm_size" {
  description = "name of resource"
  type        = string
}
variable "disktype" {
  description = "name of resource"
  type        = string
}
variable "sourceimageid" {
  description = "name of resource"
  type        = string
}
variable "zone" {
  description = "name of resource"
  type        = string
}
variable "bootdiagnostic" {
  description = "name of resource"
  type        = string
}
variable "tagname" {
  description = "name of resource"
  type        = string
}
variable "datadisktype" {
  description = "name of resource"
  type        = string
}