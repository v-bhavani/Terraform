#variable "role1" {
#    type = string
#}
#variable "role2" {
#    type = string
#}

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

variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as subaccount administrators."
}

 #variable "subaccount_service_admins" {
  #type        = list(string)
  #description = "Defines the colleagues who are added to each subaccount as subaccount service administrators."
 #}
 
