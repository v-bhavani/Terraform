provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name = var.resource_group
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefixes
}
