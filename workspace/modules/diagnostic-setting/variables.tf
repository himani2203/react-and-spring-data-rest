variable "resource_id" {
    type = string
}

variable "resource_name" {
    type = string
}

variable "log_analytics_workspace_id" {
    type = string
    default = null
}

variable "storage_account_id" {
    type = string
    default = null
}

variable "log_retention" {
    type = number
    default = 9
}

variable "metric_retention" {
    type = number
    default = 9
}

variable "diagnostics" {
    type = object({ log = list(string), metric = list(string) })
    default = {
        log = []
        metric = ["AllMetrics"]
    }
}