# module "resource_group" {
#   source = "../../modules/rg"

#   resource_group_name = var.resource_group_name
#   location            = var.location
#   tags                = var.tags
# }

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {}
# }

# Dexicon RG (matches your screenshot's tags)
module "dev_rg1" {
  source   = "../../modules/rg"
  rg_name  = "dev-rg1-modules"
  location = "westeurope"
  tags = {
    Project          = "UI migration",
    app-name         = "app1",
    company          = "bcs",
    env              = "dev"
  }
}

output "dev_rg1_status" {
  value = module.dev_rg1.creation_status
}

# Filstec RG (matches your screenshot's pattern)
module "dev_rg2_status" {
  source   = "../../modules/rg"
  rg_name  = "dev-rg2-modules"
  location = "westeurope"
  tags = {
    Project          = "UI migration",
    app-name         = "app2",
    company          = "bcs",
    env              = "dev"
  }
}

output "dev_rg2_status" {
  value = module.dev_rg2_status.creation_status
}
