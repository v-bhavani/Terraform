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
  name     = "${var.primary_resource_group_name}"
  location = "${var.primary_location}"
tags = {
  "Resource Holder" = "${var.tagname}"
}
}

resource "azurerm_resource_group" "secondary" {
  name     = "${var.secondary_resource_group_name}"
  location = "${var.secondary_location}"
tags = {
  "Resource Holder" = "${var.tagname}"
}
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm_name}"
  location              = "${var.primary_location}"
  resource_group_name   = azurerm_resource_group.primary.name
  vm_size               = "${var.vm_size}"
  network_interface_ids = [azurerm_network_interface.vm.id]

  storage_image_reference {
    id = "${var.source_image_id}"
  }

  storage_os_disk {
    name              = "tf-vm_OsDisk"
    caching           = "ReadWrite"
    create_option    = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    admin_username = "${var.vm_admin_username}"
    admin_password = "${var.vm_admin_password}"
    computer_name  = "${var.computer_name}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "${var.vault_name}"
  location            = "${var.secondary_location}"
  resource_group_name = azurerm_resource_group.secondary.name
  sku                 = "${var.vault_sku}"
}

resource "azurerm_site_recovery_fabric" "primary" {
  name                = "${var.primary_fabric_name}"
  resource_group_name = azurerm_resource_group.secondary.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  location            = "${var.primary_location}"
}

resource "azurerm_site_recovery_fabric" "secondary" {
  name                = "${var.secondary_fabric_name}"
  resource_group_name = azurerm_resource_group.secondary.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  location            = "${var.secondary_location}"
}

resource "azurerm_site_recovery_protection_container" "primary" {
  name                 = "${var.primary_container_name}"
  resource_group_name  = azurerm_resource_group.secondary.name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
}

resource "azurerm_site_recovery_protection_container" "secondary" {
  name                 = "${var.secondary_container_name}"
  resource_group_name  = azurerm_resource_group.secondary.name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name 
}

resource "azurerm_site_recovery_replication_policy" "policy" {
  name                                                 = "${var.policy_name}"
  resource_group_name                                  = azurerm_resource_group.secondary.name
  recovery_vault_name                                  = azurerm_recovery_services_vault.vault.name
  recovery_point_retention_in_minutes                  = 1 * 60
  application_consistent_snapshot_frequency_in_minutes = 1 * 60
}

resource "azurerm_site_recovery_protection_container_mapping" "container-mapping" {
  name                                      = "${var.container-mapping_name}"
  resource_group_name                       = azurerm_resource_group.secondary.name
  recovery_vault_name                       = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.primary.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.primary.name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.secondary.name
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.policy.id
}

resource "azurerm_site_recovery_network_mapping" "network-mapping" {
  name                        = "${var.network-mapping_name}"
  resource_group_name         = azurerm_resource_group.secondary.name
  recovery_vault_name         = azurerm_recovery_services_vault.vault.name
  source_recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
  target_recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
  source_network_id           = azurerm_virtual_network.primary.id
  target_network_id           = azurerm_virtual_network.secondary.id
}

resource "azurerm_storage_account" "primary" {
  name                     = "${var.primary_sa_name}"
  location                 = "${var.primary_location}"
  resource_group_name      = azurerm_resource_group.primary.name
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.sa_replication_type}"
}

resource "azurerm_virtual_network" "primary" {
  name                = "${var.primary_vnet_name}"
  resource_group_name = azurerm_resource_group.primary.name
  address_space       = "${var.primary_vnet_address_space}"
  location            = "${var.primary_location}"
}

resource "azurerm_virtual_network" "secondary" {
  name                = "${var.secondary_vnet_name}"
  resource_group_name = azurerm_resource_group.secondary.name
  address_space       = "${var.secondary_vnet_address_space}"
  location            = "${var.secondary_location}"
}

resource "azurerm_subnet" "primary" {
  name                 = "${var.primary_subnet_name}"
  resource_group_name  = azurerm_resource_group.primary.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes     = "${var.primary_subnet_address_space}"
}

resource "azurerm_subnet" "secondary" {
  name                 = "${var.secondary_subnet_name}"
  resource_group_name  = azurerm_resource_group.secondary.name
  virtual_network_name = azurerm_virtual_network.secondary.name
  address_prefixes     = "${var.secondary_subnet_address_space}"
}

resource "azurerm_public_ip" "primary" {
  name                = "${var.primary_public_ip_name}"
  allocation_method   = "${var.primary_ip_allocation_method}"
  location            = "${var.primary_location}"
  resource_group_name = azurerm_resource_group.primary.name
  sku                 = "${var.ip_sku}"
}

resource "azurerm_public_ip" "secondary" {
  name                = "${var.secondary_public_ip_name}"
  allocation_method   = "${var.secondary_ip_allocation_method}"
  location            = azurerm_resource_group.secondary.location
  resource_group_name = azurerm_resource_group.secondary.name
  sku                 = "${var.s_ip_sku}"
}

resource "azurerm_network_interface" "vm" {
  name                = "${var.nic_name}"
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
  name                                      = "${var.vm-replication_name}"
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
    target_disk_type           = "${var.disk_type}"
    target_replica_disk_type   = "${var.disk_type}"
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
  name                      = "${var.recovery_plan_name}"
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
