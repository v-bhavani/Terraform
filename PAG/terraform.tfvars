RG = "tfrg"
subnetname = "default"
vnetname = "tf-vnet"
nicname = "sym-nic2"
niclocation = "East US"
ipname = "privateip1"
staticip = "10.0.0.22"
vmname = "symvm6"
vmlocation = "East US"
vmsize = "Standard_B1ms"
username = "azureadmin"
passwd = "azureadmin@123"
osdiskname = "symosdisk6"
osdiskcatch = "ReadWrite"
disktype = "Standard_LRS"
sourceimageid = "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/cloud-demo/providers/Microsoft.Compute/galleries/Testsym/images/sym2/versions/0.0.2"
zone = 1
bootdiagnostic = "https://ansibletest01.blob.core.windows.net/"
tagname = "symphony"
datadisktype = "Standard_LRS"
datadisksize = "32"
data_disk= {
"diskname-symdisk-01" : {
disk_name = "diskname-symdisk-01"
lun = 0
}
"diskname-symdisk-02" : {
disk_name = "diskname-symdisk-02"
lun = 1
}
"diskname-symdisk-03" : {
disk_name = "diskname-symdisk-03"
lun = 2
}
"diskname-symdisk-03" : {
disk_name = "diskname-symdisk-04"
lun = 3
}
"diskname-symdisk-05" : {
disk_name = "diskname-symdisk-05"
lun = 4
}
}
