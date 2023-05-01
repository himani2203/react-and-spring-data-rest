variable "name" {
    type = string
}

variable "resource_group" {
    type = any
}

variable "service_plan_name" {
    type = string
}

variable "service_plan" {
    type = object({
        kind = string
        per_site_scaling = bool

        sku = object({
            size = string
            tier = string
        })
    })
}

variable "application" {
    type = list(object({
        image = string, port = number, enable_https = bool, site_config = any, app_settings = any
    }))
}

variable "container_registry" {
    type = any
}

variable "enable_webhooks" {
    type = bool
    default = true
}

variable "scaling_plan" {
    type = object({
        cpu = object({ min=number, max=number }),
        mem = object({ min=number, max=number })
    })
    default = null
}

variable "tags" {
    type = map(string)
    default = {}
}