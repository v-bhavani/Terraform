resource "azurerm_managed_disk" "copy" {
  name                 = var.diskname
  location             = var.location
  resource_group_name  = var.RG
  storage_account_type = var.disktype
  create_option        = "Copy"
  source_resource_id   = var.snapuri   # This should be a snapshot URI
  disk_size_gb         = var.osdisksize
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnetname
  virtual_network_name = var.vnetname
  resource_group_name  = var.RG
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = var.ipname
  location            = var.location
  resource_group_name = var.RG
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = {
    Project  = var.project
    Duration = var.duration
    Owner    = var.owner
  }
}

resource "azurerm_network_interface" "vm_nic" {
  name                = var.vm_names
  location            = var.location
  resource_group_name = var.RG

  ip_configuration {
    name                          = var.vm_names
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.ip
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  tags = {
    Project  = var.project
    Duration = var.duration
    Owner    = var.owner
  }
}

resource "azurerm_virtual_machine" "myterraformvm" {
  name                  = var.vm_names
  location              = var.location
  resource_group_name   = var.RG
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name            = azurerm_managed_disk.copy.name
    os_type         = Linux         # e.g., "Windows" or "Linux"
    managed_disk_id = azurerm_managed_disk.copy.id
    disk_size_gb    = 32
    create_option   = "Attach"
  }

  dynamic "os_profile_linux_config" {
    for_each = var.ostype == "Linux" ? [1] : []
    content {
      disable_password_authentication = false
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = var.ostype == "Windows" ? [1] : []
    content {
      provision_vm_agent        = true
      enable_automatic_upgrades = true
    }
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.bootdiagnostic
  }

  tags = {
    Project  = var.project
    Duration = var.duration
    Owner    = var.owner
  }
}

