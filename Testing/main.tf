provider "azurerm" {
  #version = "2.60.0"
  features {}
}

terraform {
  backend "azurerm"{
    resource_group_name = "BcsKS"
    storage_account_name = "bcsloganalytics"
    container_name = "tfbackupstorage"
    key = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "tftest" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "tftest" {
  name                = "${var.prefix}-network"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.tftest.location
  resource_group_name = azurerm_resource_group.tftest.name
}

resource "azurerm_subnet" "default" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.tftest.name
  virtual_network_name = azurerm_virtual_network.tftest.name
  address_prefixes     = ["10.2.35.16/28"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.tftest.location
  resource_group_name = azurerm_resource_group.tftest.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.tftest.location
  resource_group_name   = azurerm_resource_group.tftest.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_managed_disk" "tftest1" {
  name                 = "test1"
  location             = azurerm_resource_group.tftest.location
  resource_group_name  = azurerm_resource_group.tftest.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.azurerm_managed_disk}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "tftest1" {
  managed_disk_id    = azurerm_managed_disk.tftest1.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = "1"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "tftest3" {
  name                 = "test3"
  location             = azurerm_resource_group.tftest.location
  resource_group_name  = azurerm_resource_group.tftest.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.azurerm_managed_disk}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "tftest3" {
  managed_disk_id    = azurerm_managed_disk.tftest3.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = "3"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "tftest4" {
  name                 = "test4"
  location             = azurerm_resource_group.tftest.location
  resource_group_name  = azurerm_resource_group.tftest.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.azurerm_managed_disk}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "tftest4" {
  managed_disk_id    = azurerm_managed_disk.tftest4.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = "4"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "tftest5" {
  name                 = "test5"
  location             = azurerm_resource_group.tftest.location
  resource_group_name  = azurerm_resource_group.tftest.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.azurerm_managed_disk}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "tftest5" {
  managed_disk_id    = azurerm_managed_disk.tftest5.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = "5"
  caching            = "ReadWrite"
}
