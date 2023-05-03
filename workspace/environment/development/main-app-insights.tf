resource "azurerm_log_analytics_workspace" "workspace" {
  name                = format("lanw-%s", local.name)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = 2   #keeping less for testing purpose

  tags = local.resource_tags
}

resource "azurerm_application_insights" "app_insights" {
  name                = format("apin-%s", local.name)
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  workspace_id        = azurerm_log_analytics_workspace.workspace.id
  application_type    = "web"
  retention_in_days  = 30

  tags = local.resource_tags
}