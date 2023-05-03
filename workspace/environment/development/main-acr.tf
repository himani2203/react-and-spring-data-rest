resource "azurerm_container_registry" "acr" {

  name                = replace(format("creg-%s", local.name), "-", "")

  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  sku                 = "Premium"
  admin_enabled       = false

  export_policy_enabled = true

  trust_policy {
    enabled = true
  }

  retention_policy {
    days = 14
    enabled = true
  }

  anonymous_pull_enabled = false
  public_network_access_enabled = true   # For testing I am giving public access but not recommended for Production (make use of private endpoint)
  network_rule_bypass_option = "AzureServices"

  tags = local.resource_tags
}

output "acr" {
  value = azurerm_container_registry.acr
  sensitive = true
}