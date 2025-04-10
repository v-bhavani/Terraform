location     = "East US"
RG           = "cloud-demo"
disktype     = "Standard_LRS"
snapuri      = "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/cloud-demo/providers/Microsoft.Compute/snapshots/windows-update-manager"
osdisksize   = 127
diskname     = "tf-vm-disk"
ipname       = "tf-vm-ip"
ostype       = "Windows"
subnetname   = "default"
vnetname     = "asr-vm-vnet"
ip           = "10.2.0.35"
vm_names     = "tf-demo-vm"
vm_size      = "Standard_B1s"
bootdiagnostic = "https://testcloud001423.blob.core.windows.net/"
project      = "DemoProject"
duration     = "Temporary"
owner        = "irfana"

sql_admin    = "sqladminuser"
sql_pass     = "eYATTG2402@!Vor"
sqlsize      = "2"
sqlservername = "tf-sql-server-new"
sqldbname    = "tf-sql-db-new"
sqlversion   = "12.0"
sku         = "Basic"