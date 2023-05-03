module "diagnostics" {
    count = var.diagnostics == null ? 0 : length(azurerm_app_service.app_service)
    source = "../diagnostic-setting"

    resource_id = azurerm_app_service.app_service[count.index].id
    resource_name = azurerm_app_service.app_service[count.index].name
    storage_account_id = var.diagnostics.storage_account_id

    diagnostics = {
        log = ["AppServiceConsoleLogs", "AppServiceHTTPLogs", "AppServiceAppLogs", "AppServicePlatformLogs"]
        metric = ["AllMetrics"]
    }

    log_analytics_workspace_id = var.diagnostics.log_analytics_workspace_id
}