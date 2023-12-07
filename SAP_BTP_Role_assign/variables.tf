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

variable "Role" {
    type = string
}

variable "users" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as subaccount administrators."
}

 variable "custom_idp" {
    type = string
}
