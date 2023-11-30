vm_names       = ["tfvm1"]
username       = "azureadmin"
password       = "symphony@123"
#resource_group_id  = "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/tfrg"
#virtual_network_id = "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/tfrg/providers/Microsoft.Network/virtualNetworks/tf-vnet"
resourcedetails = "tfrg"
subnetname = "default" 
vnetname = "tf-vnet"
RG = "tfrg"
location = "East US"
ip = ["10.0.0.21"]
vm_size = "Standard_D2as_v5"
disktype = "Standard_LRS"
sourceimageid = "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/cloud-demo/providers/Microsoft.Compute/galleries/Testsym/images/sym2/versions/0.0.2"
# zone = "1"
bootdiagnostic = "https://testcloud001423.blob.core.windows.net/"
tagname = "Irfana"
datadisktype = "Standard_LRS"
data_disk= {
"data-disk-1" : {
vm_name= "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/tfvm1"
 disk_name = "data-disk-1"
 disk_size = 128
  lun = 1
   }
"data-disk-2" : {
vm_name= "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/tfvm1"
 disk_name = "data-disk-2"
 disk_size = 64
  lun = 2
   }
"data-disk-3" : {
vm_name= "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/tfvm1"
 disk_name = "data-disk-3"
 disk_size = 64
  lun = 3
   }
"data-disk-4" : {
vm_name= "/subscriptions/bf18f464-1469-4216-834f-9c6694dbfe26/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/tfvm1"
 disk_name = "data-disk-4"
 disk_size = 128
  lun = 4
   }
}
