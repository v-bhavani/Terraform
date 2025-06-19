variable "rg_name" {
  description = "Resource group name (e.g., 'p-vw-dexicon-weu-rg')"
  type        = string
}

variable "location" {
  description = "Azure region (e.g., 'westeurope')"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default     = {}
}