variable "region" {
  type        = string
  description = "Region where the subaccount will be running."
}

variable "parent_directory" {
  type        = string
  description = "name of the parent directory or null for the global account as parent."
  default     = null
}

variable "subaccount_name" {
  type        = string
  description = "Short name for the organization the subaccount shall belong to."
}

variable "directory_name" {
  type        = string
  description = "Defines to which organization the subaccount shall belong to."
}

variable "globalaccount" {
  description = "BTP global account"
  type        = string
  sensitive   = true
}

variable "username" {
  description = "BTP username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "BTP user password"
  type        = string
  sensitive   = true
}

variable "costcenter" {
  type        = string
  description = "Defines the cost center for the subaccount"
}

variable "owner" {
  type        = string
  description = "Defines the owner of the subaccount"
}

variable "team" {
  type        = string
  description = "Defines the team of the subaccount"
}

variable "architect" {
  type        = string
  description = "Defines the email address of the architect for the subaccount"
}
variable "entitlement_name" {
  type        = string
}
variable "plan" {
  type        = string
}
