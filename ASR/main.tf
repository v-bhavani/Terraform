provider "azurerm" {
  features {}
}
terraform {
  backend "azurerm"{
    resource_group_name = "cloud-demo"
    storage_account_name = "evitest"
    container_name = "tftest"
    key = "terraformtest1.tfstate"
 }
}
resource "azurerm_resource_group" "primary" {
  name     = "tfrg-p"
  location = "East US"
tags = {
  "Resource Holder" = "Irfana"
}
}

resource "azurerm_resource_group" "secondary" {
  name     = "tfrg-s"
  location = "Central US"
tags = {
  "Resource Holder" = "Irfana"
}
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "tf-vm"
  location              = azurerm_resource_group.primary.location
  resource_group_name   = azurerm_resource_group.primary.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.vm.id]

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    version   = "8.0"
  }

  storage_os_disk {
    name              = "tf-vm_OsDisk_1_e33c7ca803d844ab8ab19322ff2ab8a1"
    os_type           = "Linux"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    admin_username = "azureadmin"
    admin_password = "H3r3andth3r3"
    computer_name  = "tf-vm"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "tfvault"
  location            = azurerm_resource_group.secondary.location
  resource_group_name = azurerm_resource_group.secondary.name
  sku                 = "Standard"
}

resource "azurerm_site_recovery_fabric" "primary" {
  name                = "primary-fabric"
  resource_group_name = azurerm_resource_group.secondary.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  location            = azurerm_resource_group.primary.location
}

resource "azurerm_site_recovery_fabric" "secondary" {
  name                = "secondary-fabric"
  resource_group_name = azurerm_resource_group.secondary.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  location            = azurerm_resource_group.secondary.location
}

resource "azurerm_site_recovery_protection_container" "primary" {
  name                 = "primary-protection-container"
  resource_group_name  = azurerm_resource_group.secondary.name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
}

resource "azurerm_site_recovery_protection_container" "secondary" {
  name                 = "secondary-protection-container"
  resource_group_name  = azurerm_resource_group.secondary.name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
}

resource "azurerm_site_recovery_replication_policy" "policy" {
  name                                                 = "policy"
  resource_group_name                                  = azurerm_resource_group.secondary.name
  recovery_vault_name                                  = azurerm_recovery_services_vault.vault.name
  recovery_point_retention_in_minutes                  = 1 * 60
  application_consistent_snapshot_frequency_in_minutes = 1 * 60
}

resource "azurerm_site_recovery_protection_container_mapping" "container-mapping" {
  name                                      = "container-mapping"
  resource_group_name                       = azurerm_resource_group.secondary.name
  recovery_vault_name                       = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.primary.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.primary.name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.secondary.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.policy.id
}

resource "azurerm_site_recovery_network_mapping" "network-mapping" {
  name                        = "network-mapping"
  resource_group_name         = azurerm_resource_group.secondary.name
  recovery_vault_name         = azurerm_recovery_services_vault.vault.name
  source_recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
  target_recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
  source_network_id           = azurerm_virtual_network.primary.id
  target_network_id           = azurerm_virtual_network.secondary.id
}

resource "azurerm_storage_account" "primary" {
  name                     = "tfrgstorageaccount"
  location                 = azurerm_resource_group.primary.location
  resource_group_name      = azurerm_resource_group.primary.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "primary" {
  name                = "tf-vm-vnet"
  resource_group_name = azurerm_resource_group.primary.name
  address_space       = ["10.9.0.0/16"]
  location            = azurerm_resource_group.primary.location
}

resource "azurerm_virtual_network" "secondary" {
  name                = "tf-vm-vnet-s"
  resource_group_name = azurerm_resource_group.secondary.name
  address_space       = ["10.15.0.0/16"]
  location            = azurerm_resource_group.secondary.location
}

resource "azurerm_subnet" "primary" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.primary.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes     = ["10.9.0.0/24"]
}

resource "azurerm_subnet" "secondary" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.secondary.name
  virtual_network_name = azurerm_virtual_network.secondary.name
  address_prefixes     = ["10.15.0.0/24"]
}

resource "azurerm_public_ip" "primary" {
  name                = "tf-vm-ip"
  allocation_method   = "Static"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  sku                 = "Standard"
}

resource "azurerm_public_ip" "secondary" {
  name                = "tf-vm-ip-s"
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.secondary.location
  resource_group_name = azurerm_resource_group.secondary.name
  sku                 = "Basic"
}

resource "azurerm_network_interface" "vm" {
  name                = "tf-vm449"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name

  ip_configuration {
    name                          = "tf-pvt-vm"
    subnet_id                     = azurerm_subnet.primary.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.primary.id
  }
}

resource "azurerm_site_recovery_replicated_vm" "vm-replication" {
  name                                      = "vm-replication"
  resource_group_name                       = azurerm_resource_group.secondary.name
  recovery_vault_name                       = azurerm_recovery_services_vault.vault.name
  source_recovery_fabric_name               = azurerm_site_recovery_fabric.primary.name
  source_vm_id                              = azurerm_virtual_machine.vm.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.policy.id
  source_recovery_protection_container_name = azurerm_site_recovery_protection_container.primary.name

  target_resource_group_id                = azurerm_resource_group.secondary.id
  target_recovery_fabric_id               = azurerm_site_recovery_fabric.secondary.id
  target_recovery_protection_container_id = azurerm_site_recovery_protection_container.secondary.id

  managed_disk {
    disk_id                    = azurerm_virtual_machine.vm.storage_os_disk[0].managed_disk_id
    staging_storage_account_id = azurerm_storage_account.primary.id
    target_resource_group_id   = azurerm_resource_group.secondary.id
    target_disk_type           = "Standard_HDD_LRS"
    target_replica_disk_type   = "Standard_HDD_LRS"
  }

  network_interface {
    source_network_interface_id   = azurerm_network_interface.vm.id
    target_subnet_name            = azurerm_subnet.secondary.name
    recovery_public_ip_address_id = azurerm_public_ip.secondary.id
  }

  depends_on = [
    azurerm_site_recovery_protection_container_mapping.container-mapping,
    azurerm_site_recovery_network_mapping.network-mapping,
  ]
}

resource "azurerm_site_recovery_replication_recovery_plan" "example" {
  name                      = "tf-recover-plan"
  recovery_vault_id         = azurerm_recovery_services_vault.vault.id
  source_recovery_fabric_id = azurerm_site_recovery_fabric.primary.id
  target_recovery_fabric_id = azurerm_site_recovery_fabric.secondary.id

  recovery_group {
    type                       = "Boot"
    replicated_protected_items = [azurerm_site_recovery_replicated_vm.vm-replication.id]
  }
  recovery_group {
    type = "Failover"
  }
  recovery_group {
    type = "Shutdown"
  }
}