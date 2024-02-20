variable "resource_group" {
  description = "The name of the resource group."
}

variable "project" {
  description = "The name of the project."
  type = stirng
}
variable "owner" {
  description = "The name of the owner."
  type = stirng
}
variable "duration" {
  description = "time required for testing."
  type = stirng
}

variable "location" {
  description = "The location of the resource group."
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
}

variable "address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet."
}

variable "subnet_address_prefixes" {
  description = "The address prefixes of the subnet."
  type        = list(string)
}
