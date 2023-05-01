locals {
    deployments = [ for app in azurerm_app_service.app_service : {
        name = app.name
        username = app.site_credential[0].username
        password = app.site_credential[0].password
    }]
  }

resource "azurerm_container_registry_webhook" "webhook" {
  count = var.enable_webhooks ? length(local.deployments) : 0
  name                = replace(local.deployments[count.index]["name"], "-", "")

  registry_name       = var.container_registry.name
  location            = "eastus2"
  resource_group_name = "rgrp-dva2-np-dev000"

  status      = "enabled"
  actions     = ["push"]
  service_uri = format("https://%s:%s@%s.scm.azurewebsites.net/docker/hook", local.deployments[count.index]["username"], local.deployments[count.index]["password"], local.deployments[count.index]["name"])
  scope       = var.application[count.index].image
  
  custom_headers = merge( var.tags, {
    "Content-Type" = "application/json"
  })

  tags = var.tags
}