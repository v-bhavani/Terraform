variable "username" {
    description = "give username"
    type        = string
}

variable "policy_arn" {
  type    = list(string)
}

/*  default = [
    "[var.policy_arn]"
  ]
  */

variable "group_names" {
    type        = list(string)
}

variable "enable_console_access" {
  description = "Set to true to enable console access for the IAM user"
  type        = string
}

variable "account_id" {
    description = "give account number"
    type        = number
}