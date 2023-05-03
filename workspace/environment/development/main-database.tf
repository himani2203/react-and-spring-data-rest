resource "azurerm_mssql_server" "server" {
  name                         = format("asql-%s", local.name)
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location
  version                      = "12.0"
  administrator_login          = "adm1n4141"
  administrator_login_password = "h1-m@n!-4141-p455w0rd"   # We can also store in key vault secret

  tags = local.resource_tags

}

resource "azurerm_mssql_database" "database" {
  name                = "springboot-db"
  server_id         = azurerm_mssql_server.server.id
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  
  short_term_retention_policy {
    retention_days = 14
  }

  tags = local.resource_tags

}