module "app-service" {
  count = length(var.app_service)
  source = "../../modules/app-service"

  name = format("wapp-%s", local.name)
  service_plan_name = format("aspl-%s", local.name)

  scaling_plan = var.app_service[count.index].scaling_plan
  service_plan = {
    kind = "Linux", per_site_scaling = true
    sku = {
      tier = "Standard"
      size = var.app_service[count.index].service_plan.size
    }
  }

  enable_webhooks = true  # This is for continuous deployment
  application = [for i in range(length(var.app_service[count.index].container)) :
    {
      image = var.app_service[count.index].container[i].image,
      port = coalesce(var.app_service[count.index].container[i].port, 80)
      enable_https = coalesce(var.app_service[count.index].container[i].enable_https, true)
      app_settings = {}
      site_config = {}
    }
  ]

  container_registry = azurerm_container_registry.acr
  app_insights = azurerm_application_insights.app_insights
  resource_group = azurerm_resource_group.resource_group

  diagnostics = {
    storage_account_id = data.azurerm_storage_account.storage.id
    log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
  }
  
  tags = local.resource_tags
}

output "app-service" {
  value = module.app-service
  sensitive = true
}