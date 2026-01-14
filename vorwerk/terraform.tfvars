location     = "East us"
RG           = "cloud-demo"
disktype     = "Standard_LRS"
snapuri      = "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/cloud-demo/providers/Microsoft.Compute/snapshots/regsnap"
osdisksize   = 32
diskname     = "vmdiskreg"
ipname       = "vmipreg"
ostype       = "linux"
subnetname   = "default"
vnetname     = "asr-vm-vnet"
ip           = "10.2.0.90"
vm_names     = "regvmtf"
vm_size      = "Standard_D2as_v5"
bootdiagnostic = "https://testcloud001423.blob.core.windows.net/"
project      = "regression"
duration     = "one-day"
owner        = "Irfana"

sql_admin      = "sqladminuser"
sql_pass       = "P@ssw0rd!123"     
sqlsize        = 20               
sqlservername  = "tfsql-demo"
sqlversion     = "12.0"           
sku            = "GP_S_Gen5_1"         
sqldbname1     = "AppDB"
sqldbname2     = "ReportingDB"
collation      = "SQL_Latin1_General_CP1_CI_AS"
subnet_id      = "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/cloud-demo/providers/Microsoft.Network/virtualNetworks/asr-vm-vnet/subnets/default"





