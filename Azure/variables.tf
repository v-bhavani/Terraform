variable "RG" {
  description = "name of the vm"
  type        = string
}

variable "osdiskname" {
  description = "name of osdiskname"
  type        = string
}

variable "snaplocation" {
  description = "name of snapshotlocation"
  type        = string
}

variable "snaprgname" {
  description = "name of name of snaprg"
  type        = string
}

variable "disktype" {
  description = "name of disktype"
  type        = string
}


variable "snapuri" {
  description = "name of snapshoturi"
  type        = string
}

variable "osdisksize" {
  description = "name of size of osdisk"
  type        = string
}

variable "subnetname" {
  description = "name of size of subnetname"
  type        = string
}

variable "vnetname" {
  description = "name of size of vnetname"
  type        = string
}

variable "nicname" {
  description = "name of nicname"
  type        = string
}

variable "niclocation" {
  description = "name of niclocation"
  type        = string
}

variable "vmname" {
  description = "name of vmname"
  type        = string
}

variable "vmlocation" {
  description = "vm location"
  type        = string
}

variable "vmsize" {
  description = "Standard_B2ms"
  type        = string
}

variable "staticip" {
  description = "name of staticipaddress"
  type        = string
}

variable "tagname" {
  description = "name of tagname"
  type        = string
}
