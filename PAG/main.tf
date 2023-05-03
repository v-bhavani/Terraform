provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm"{
    resource_group_name = "BcsKS"
    storage_account_name = "bcsloganalytics"
    container_name = "tfnew"
    key = "terraforr16.tfstate"
 }
}

# Define the existing resource group
data "azurerm_resource_group" "existing_rg" {
  name = "${var.RG}"
}
variable "data_disk" {
type = map (object({
disk_name = string
lun = number
}))
/*default = {
}*/
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
    name                          = "${var.ipname}"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.staticip}"
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "main" {
    name                  = "${var.vmname}"
    location              = "${var.vmlocation}"
    resource_group_name   = data.azurerm_resource_group.existing_rg.name
    network_interface_ids = [azurerm_network_interface.vm_nic.id]
    size               = "${var.vmsize}"

 admin_username = "${var.username}"
 admin_password = "${var.passwd}"
 disable_password_authentication = false

 os_disk {
 name = "${var.osdiskname}"
 caching = "${var.osdiskcatch}"
 storage_account_type = "${var.disktype}"
}

 source_image_id = "${var.sourceimageid}"

 zone = "${var.zone}"

 boot_diagnostics {
    storage_account_uri = "${var.bootdiagnostic}"
  }

  tags = {
    "Resource Holder" = "${var.tagname}"
  }
/*  lifecycle {
    prevent_destroy = true
   }*/
}
#creating disk
resource "azurerm_managed_disk" "source1" {
depends_on = [azurerm_linux_virtual_machine.main]
for_each = var.data_disk
  name                 = each.value.disk_name
  location             = "${var.vmlocation}"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  storage_account_type = "${var.datadisktype}"
  create_option        = "Empty"
  disk_size_gb         = "${var.datadisksize}"
  zone                 = "${var.zone}"

  tags = {
    "Resource Holder" = "${var.tagname}"
  }
}
# Attach the disk to the existing virtual machine
resource "azurerm_virtual_machine_data_disk_attachment" "source2" {
depends_on = [azurerm_linux_virtual_machine.main,azurerm_managed_disk.source1]
  for_each = var.data_disk
  managed_disk_id    = lookup({for k, source1 in azurerm_managed_disk.source1 : k => source1.id}, each.value.disk_name, "what?")
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = each.value.lun
  caching            = "ReadWrite"
}