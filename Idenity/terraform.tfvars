tenant_id = "60ef6b37-d4a1-441f-ae7a-90f02d62fb59"
subscription_id = "3341a86f-6fc1-44cd-9b17-7cf2b774ad60"
vm_names       = ["vm1", "vm2"]
username       = "adminuser1"
password       = "H3r3andth3r3"
#resource_group_id  = "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg"
#virtual_network_id = "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Network/virtualNetworks/tf-vnet"
resourcedetails = "tfrg"
subnetname = "default"
vnetname = "tf-vnet"
RG = "tfrg"
location = "East US"
ip = ["10.0.0.21", "10.0.0.22"]
vm_size = "Standard_B2s"
disktype = "Standard_LRS"
sourceimageid = "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/cloud-demo/providers/Microsoft.Compute/galleries/Testsym/images/sym2/versions/0.0.2"
zone = "1"
bootdiagnostic = "https://ansibletest01.blob.core.windows.net/"
tagname = "soundhar"
datadisktype = "Standard_LRS"
data_disk= {
"data-disk-1" : {
vm_name= "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/vm1"
 disk_name = "data-disk-1"
 disk_size = 50
  lun = 1
   }
"data-disk-2" : {
vm_name= "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/vm1"
 disk_name = "data-disk-2"
 disk_size = 50
  lun = 2
   }
"data-disk-3" : {
vm_name= "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/vm2"
 disk_name = "data-disk-3"
 disk_size = 50
  lun = 1
   }
"data-disk-4" : {
vm_name= "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Compute/virtualMachines/vm2"
 disk_name = "data-disk-4"
 disk_size = 50
  lun = 2
   }

}