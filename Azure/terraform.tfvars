RG = "cloud-demo"
osdiskname = "symphony3"
snaplocation = "East US"
snaprgname = "cloud-demo"
disktype = "Standard_LRS"
snapuri = "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Compute/snapshots/mysnap"
osdisksize = "64"
subnetname = "default"
vnetname = "cloud-demo-vnet"
nicname = "testnicsym3"
niclocation = "East US"
staticip = "10.11.0.23"
vmname = "symphony3"
vmlocation = "East US"
vmsize = "Standard_E2ds_v4"
tagname = "soundhar"
availbleset = "/subscriptions/3341a86f-6fc1-44cd-9b17-7cf2b774ad60/resourceGroups/tfrg/providers/Microsoft.Compute/availabilitySets/tftest"
bootdiagnostic = "https://ansibletest01.blob.core.windows.net/"
data_disk= {
"diskname-datadisk-01" : {
disk_name = "diskname-datadisk-01"
lun = 2
}
"diskname-datadisk-02" : {
disk_name = "diskname-datadisk-02"
lun = 3
}
"diskname-datadisk-03" : {
disk_name = "diskname-datadisk-03"
lun = 4
}
"diskname-datadisk-04" : {
disk_name = "diskname-datadisk-04"
lun = 5

}
}
