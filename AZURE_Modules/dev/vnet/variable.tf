variable "location" {
  description = "Azure region"
  type        = string
}

# App1 VNet
variable "app1_vnet_name" {
  type = string
}

variable "app1_rg_name" {
  type = string
}

variable "app1_address_space" {
  type = list(string)
}

variable "app1_subnets" {
  type = map(string)
}

variable "app1_tags" {
  type = map(string)
}

# # App2 VNet
# variable "app2_vnet_name" {
#   type = string
# }

# variable "app2_rg_name" {
#   type = string
# }

# variable "app2_address_space" {
#   type = list(string)
# }

# variable "app2_subnets" {
#   type = map(string)
# }

# variable "app2_tags" {
#   type = map(string)
# }