provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm"{
    resource_group_name = "cloud-demo"
    storage_account_name = "testcloud001423"
    container_name = "terraform"
    key = "terraformtest3.tfstate"
}
}

data "azurerm_resource_group" "existing" {
  name = "${var.name}"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks-cluster"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  dns_prefix          = "exampleaks"
  kubernetes_version  = "${var.kubernetesversion}"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "${var.vmsize}"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    "environment" = "${var.tagname}"
  }
}