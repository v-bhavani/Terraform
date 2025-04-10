# resource "azurerm_resource_group" "rg" {
#   name     = "tf-sql-db-example"
#   location = var.location
# }

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sqlservername
  resource_group_name          = var.RG
  location                     = var.location
  version                      = var.sqlversion
  administrator_login          = var.sql_admin
  administrator_login_password = var.sql_pass
  minimum_tls_version          = "1.2"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.sqldbname
  server_id      = azurerm_mssql_server.sql_server.id
  sku_name       = var.sku
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = var.sqlsize
  zone_redundant = false
  read_scale     = false

  tags = {
    environment = "dev"
  }
}

# resource "azurerm_mssql_firewall_rule" "firewall" {
#   name             = "AllowAzureServices"
#   server_id        = azurerm_mssql_server.sql_server.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "0.0.0.0"
# }
