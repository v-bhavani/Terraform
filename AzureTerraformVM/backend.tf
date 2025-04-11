terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-demo"
    storage_account_name = "testcloud001423"
    container_name       = "terraform"
    key                  = "terraformtest001.tfstate"
  }
}
