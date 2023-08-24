variable "primary_resource_group_name" {
  description = "name of resource"
  type        = string
}

variable "secondary_resource_group_name" {
  description = "name of resource"
  type        = string
}

variable "primary_location" {
  description = "name of primary location"
  type        = string
}

variable "secondary_location" {
  description = "name of secondary location"
  type        = string
}

variable "vm_name" {
  description = "name of resource"
  type        = string
}
variable "vm_size" {
  description = "size of resource"
  type        = string
}
variable "source_image_id" {
  description = "name of resource"
  type        = string
}
variable "vm_admin_username" {
  description = "name of resource"
  type        = string
}
variable "vm_admin_password" {
  description = "name of resource"
  type        = string
}
variable "computer_name" {
  description = "name of resource"
  type        = string
}
variable "vault_name" {
  description = "name of resource"
  type        = string
}
variable "vault_sku" {
  description = "name of resource"
  type        = string
}
variable "primary_fabric_name" {
  description = "name of resource"
  type        = string
}
variable "secondary_fabric_name" {
  description = "name of resource"
  type        = string
}
variable "primary_container_name" {
  description = "name of resource"
  type        = string
}
variable "secondary_container_name" {
  description = "name of resource"
  type        = string
}
variable "policy_name" {
  description = "name of resource"
  type        = string
}
variable "container-mapping_name" {
  description = "name of resource"
  type        = string
}
variable "network-mapping_name" {
  description = "name of resource"
  type        = string
}
variable "primary_sa_name" {
  description = "name of resource"
  type        = string
}
variable "storage_account_tier" {
  description = "name of resource"
  type        = string
}
variable "sa_replication_type" {
  description = "name of resource"
  type        = string
}
variable "primary_vnet_name" {
  description = "name of resource"
  type        = string
}
variable "secondary_vnet_name" {
  description = "name of resource"
  type        = string
}
variable "primary_subnet_name" {
  description = "name of resource"
  type        = string
}
variable "secondary_subnet_name" {
  description = "name of resource"
  type        = string
}
variable "primary_vnet_address_space" {
  description = "name of resource"
  type        = list(string)
}
variable "secondary_vnet_address_space" {
  description = "name of resource"
  type        = list(string)
}
variable "primary_subnet_address_space" {
  description = "name of resource"
  type        = list(string)
}
variable "secondary_subnet_address_space" {
  description = "name of resource"
  type        = list(string)
}
variable "primary_public_ip_name" {
  description = "name of resource"
  type        = string
}
variable "primary_ip_allocation_method" {
  description = "name of resource"
  type        = string
}
variable "secondary_public_ip_name" {
  description = "name of resource"
  type        = string
}
variable "secondary_ip_allocation_method" {
  description = "name of resource"
  type        = string
}
variable "ip_sku" {
  description = "name of resource"
  type        = string
}
variable "s_ip_sku" {
  description = "name of resource"
  type        = string
}
variable "nic_name" {
  description = "name of resource"
  type        = string
}
variable "vm-replication_name" {
  description = "name of resource"
  type        = string
}
variable "disk_type" {
  description = "name of resource"
  type        = string
}
variable "recovery_plan_name" {
  description = "name of resource"
  type        = string
}
variable "tagname" {
  description = "name of resource"
  type        = string
}