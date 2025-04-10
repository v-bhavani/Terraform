module "vm" {
  source              = "./modules/vm"
  location            = var.location
  RG                  = var.RG
  disktype            = var.disktype
  snapuri             = var.snapuri
  osdisksize          = var.osdisksize
  subnetname          = var.subnetname
  ipname              = var.ipname
  ostype              = var.ostype
  diskname            = var.diskname
  vnetname            = var.vnetname
  ip                  = var.ip
  vm_names            = var.vm_names
  vm_size             = var.vm_size
  bootdiagnostic      = var.bootdiagnostic
  project             = var.project
  duration            = var.duration
  owner               = var.owner
}

module "sql" {
  source          = "./modules/sql" # You need a separate module to just create the server
  sql_admin       = var.sql_admin
  sql_pass        = var.sql_pass
  location        = var.location
  RG              = var.RG
  sqlservername   = var.sqlservername
  sqlversion      = var.sqlversion
  sqldbname1      = var.sqldbname1
  sqldbname2      =var.sqldbname2
  collation       =var.collation
  subnet_id       =var.subnet_id
  sku            =var.sku
  sqlsize        =var.sqlsize
}
