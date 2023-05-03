resource "azurerm_app_service_plan" "app_service_plan" {

  name                = var.service_plan_name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  kind                = var.service_plan.kind
  reserved            = title(var.service_plan.kind) == "Linux" ? true : false
  is_xenon            = title(var.service_plan.kind) == "Xenon" ? true : false
  per_site_scaling    = var.service_plan.per_site_scaling
  
  sku {
    tier = var.service_plan.sku.tier
    size = var.service_plan.sku.size
  }

  tags = var.tags

}

module "scaling_plan" {
  count = var.scaling_plan != null ? 1 : 0
  source = "../autoscale"
  resource = azurerm_app_service_plan.app_service_plan

  cpu_percentage = {
    name = "CpuPercentage"
    min = var.scaling_plan.cpu.min
    max = var.scaling_plan.cpu.max
  }

  mem_percentage = {
    name = "MemoryPercentage"
    min = var.scaling_plan.mem.min
    max = var.scaling_plan.mem.max
  }

  tags = var.tags
}

locals {
  default_app_settings = merge(
    var.app_insights == null ? {} : {
      APPLICATION_INSIGHTS_IKEY = try(var.app_insights.instrumentation_key, "")
      APPINSIGHTS_INSTRUMENTATIONKEY =  try(var.app_insights.instrumentation_key, "")
      APPLICATIONINSIGHTS_CONNECTION_STRING = try(var.app_insights.connection_string, "")
      ApplicationInsightsAgents_EXTENSION_VERSION = "~2"
    }
  )
}