data "azurerm_monitor_diagnostic_categories" "default" {
  resource_id = var.resource_id
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics_setting" {
  name               = format("%s-diagnostic", var.resource_name)

  target_resource_id = var.resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id = var.storage_account_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.default.logs
    content {
        category = log.value
        enabled = contains(var.diagnostics.log, log.value)

        retention_policy {
            enabled = var.log_retention > 0
            days = var.log_retention
        }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.default.metrics
    content {
        category = metric.value
        enabled = contains(var.diagnostics.metric, metric.value)

        retention_policy {
            enabled = var.metric_retention > 0
            days = var.metric_retention
        }
    }
  }

  lifecycle {
    ignore_changes = [log, metric]
  }
}