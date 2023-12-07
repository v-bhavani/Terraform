variable "subaccount_id" {
    type = string
}

variable "global_account" {
    type = string
}
variable "username" {
    type = string
}
variable "password" {
    type = string
}

variable "Role10" {
    type = string
}

variable "Role13" {
    type = string
}

variable "Z_CUSTOM_users" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as subaccount administrators."
}

 variable "subaccount_service_admin_users" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as subaccount service administrators."
 }
 
 variable "custom_idp" {
    type = string
}
