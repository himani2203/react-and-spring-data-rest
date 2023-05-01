# resource "azurerm_storage_account" "storage" {
#   name                = replace(format("sacc-%s", local.name), "-", "")

#   resource_group_name = azurerm_resource_group.resource_group.name
#   location            = azurerm_resource_group.resource_group.location

#   account_tier             = "Standard"
#   account_kind             = "StorageV2"
#   account_replication_type = "LRS"
#   enable_https_traffic_only = true
#   public_network_access_enabled = true

#   network_rules {
#     default_action             = "Allow"
#    # ip_rules                   = flatten([var.WhiteListedCIDRRange])
#    # virtual_network_subnet_ids = flatten([[for subnet in module.storage_service_endpoint.subnet : subnet.id]])
#     #bypass = ["Metrics", "AzureServices", "Logging"]
#   }

#   tags = local.resource_tags
# }