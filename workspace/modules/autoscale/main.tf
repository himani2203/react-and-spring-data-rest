resource "azurerm_monitor_autoscale_setting" "autoscale_setting" {
  name                = format("autoscale-%s", var.resource.name)

  resource_group_name = var.resource.resource_group_name
  location            = var.resource.location
  target_resource_id  = var.resource.id

  profile {
    name = "CPU&MEMAutoScale"

    capacity {
      default = var.capacity.default
      minimum = var.capacity.minimum
      maximum = var.capacity.maximum
    }

    rule {
      metric_trigger {
        metric_name        = var.cpu_percentage.name
        metric_resource_id = var.resource.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.cpu_percentage.max
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = var.cpu_percentage.name
        metric_resource_id = var.resource.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.cpu_percentage.min
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = var.mem_percentage.name
        metric_resource_id = var.resource.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.mem_percentage.max
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = var.mem_percentage.name
        metric_resource_id = var.resource.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.mem_percentage.min
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

  }

  notification {
    email {
      send_to_subscription_administrator    = true
      custom_emails                         = var.notification.email
    }
  }

  tags = var.tags
}