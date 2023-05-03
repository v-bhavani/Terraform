provider "azurerm" {
  features {}
}

# Define the existing resource group
data "azurerm_resource_group" "existing_rg" {
  name = "${var.RG}"
}

resource "azurerm_managed_disk" "copy" {
  name = "${var.osdiskname}"
  location = "${var.snaplocation}"
  resource_group_name = "${var.snaprgname}"
  storage_account_type = "${var.disktype}"
  create_option = "Copy"
  source_resource_id = "${var.snapuri}"
  disk_size_gb = "${var.osdisksize}"
}

# Define the existing virtual network and subnet
data "azurerm_subnet" "existing_subnet" {
  name                 = "${var.subnetname}"
  virtual_network_name = "${var.vnetname}"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
}

# Define the network interface for the VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.nicname}"
  location            = "${var.niclocation}"
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  ip_configuration {
    name                          = "${var.nicname}"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.staticip}"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "myterraformvm" {
    name                  = "${var.vmname}"
    location              = "${var.vmlocation}"
    resource_group_name   = data.azurerm_resource_group.existing_rg.name
    network_interface_ids = [azurerm_network_interface.vm_nic.id]
    vm_size               = "${var.vmsize}"


    storage_os_disk {
    name              = "${azurerm_managed_disk.copy.name}"
    os_type           = "Linux"
    managed_disk_id   = "${azurerm_managed_disk.copy.id}"
    disk_size_gb      = "${var.osdisksize}"
    create_option     = "Attach"
    }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    "Resource Holder" = "${var.tagname}"
  }
}