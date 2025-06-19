terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-demo"
    storage_account_name = "testcloud001423"
    container_name      = "terraform-modules"
    key                 = "vnet.tfstate"
  }
}