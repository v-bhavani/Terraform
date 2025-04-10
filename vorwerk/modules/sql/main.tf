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

resource "azurerm_mssql_database" "sql_db1" {
  name           = var.sqldbname1
  server_id      = azurerm_mssql_server.sql_server.id
  sku_name       = var.sku
  collation      = var.collation
  max_size_gb    = var.sqlsize
}

resource "azurerm_mssql_database" "sql_db2" {
  name           = var.sqldbname2
  server_id      = azurerm_mssql_server.sql_server.id
  sku_name       = var.sku
  collation      = var.collation
  max_size_gb    = var.sqlsize
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = "sql-private-endpoint"
  location            = var.location
  resource_group_name = var.RG
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "sqlserverLink"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}


# resource "azurerm_mssql_firewall_rule" "firewall" {
#   name             = "AllowAzureServices"
#   server_id        = azurerm_mssql_server.sql_server.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "0.0.0.0"
# }
