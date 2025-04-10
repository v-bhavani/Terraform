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
  source     = "./modules/sql"
  sql_admin  = var.sql_admin
  sql_pass   = var.sql_pass
  location   = var.location
  RG         = var.RG
  sqlsize    = var.sqlsize
  sqlservername = var.sqlservername
  sqldbname     = var.sqldbname
  sqlversion    = var.sqlversion
  sku           = var.sku
}
