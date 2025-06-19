# # variable "resource_group_name" {
# #   description = "The name of the resource group"
# #   type        = string
# # }

# # variable "location" {
# #   description = "The Azure region where the resource group will be created"
# #   type        = string
# # }

# # variable "tags" {
# #   description = "Tags to apply to the resource group"
# #   type        = map(string)
# #   default     = {}
# # }

# variable "dev_rg_name" {
#   description = "Name of the development resource group"
#   type        = string
# }

# variable "qa_rg_name" {
#   description = "Name of the QA resource group"
#   type        = string
# }

# variable "prod_rg_name" {
#   description = "Name of the production resource group"
#   type        = string
# }

# # Location-specific variables
# variable "dev_location" {
#   description = "Azure region for development resource group"
#   type        = string
# }

# variable "qa_location" {
#   description = "Azure region for QA resource group"
#   type        = string
# }

# variable "prod_location" {
#   description = "Azure region for production resource group"
#   type        = string
# }

# variable "common_tags" {
#   description = "Common tags for all resource groups"
#   type        = map(string)
#   default     = {
#     ManagedBy = "Terraform"
#   }
# }