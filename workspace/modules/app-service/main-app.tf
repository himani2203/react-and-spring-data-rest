resource "azurerm_app_service" "app_service" {
  count = length(var.application)
  name                = format("%s%d", var.name, (count.index + 1))
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  https_only = var.application[count.index].enable_https

  app_settings = merge({
    WEBSITES_PORT = var.application[count.index].port
    DOCKER_ENABLE_CI = "true"
    DOCKER_REGISTRY_SERVICE_URL = format("https://%s", var.container_registry.login_server)
  }, local.default_app_settings, var.application[count.index].app_settings)

  dynamic "site_config" {
    for_each = [var.application[count.index].site_config]
    content {
        acr_use_managed_identity_credentials = lookup(site_config.value, "acr_use_managed_identity_credentials", true)
        linux_fx_version = title(var.service_plan.kind) == "Linux" ? format("DOCKER|%s/%s", var.container_registry.login_server, var.application[count.index].image) : null

    }
  }

  identity {
    type = "SystemAssigned" 
  }
  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  for_each = { for app in azurerm_app_service.app_service : app.name => app }
  scope                = var.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = each.value.identity[0].principal_id
}
