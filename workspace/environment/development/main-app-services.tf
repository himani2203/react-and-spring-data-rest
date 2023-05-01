resource "azurerm_resource_group" "resource_group_1" {
  name     = format("rgrp-%s%d", local.name, 1)

  location = "eastus"
  tags = local.resource_tags
}

resource "azurerm_management_lock" "subscription-level-1" {
  name       = format("rgrp-%s-lock%d", local.name, 1)
  scope      = azurerm_resource_group.resource_group_1.id

  lock_level = "CanNotDelete"
  notes      = "Resource Group Is Locked"

  lifecycle {
    ignore_changes = [notes]
  }
}

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
      #tier = "PremiumV2"
      size = var.app_service[count.index].service_plan.size
    }
  }

  enable_webhooks = true
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

  resource_group = azurerm_resource_group.resource_group_1
  tags = local.resource_tags
}

output "app-service" {
  value = module.app-service
  sensitive = true
}