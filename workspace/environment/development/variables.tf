variable "resource" {
    type = object({
        tags = map(string), naming = object({
            environment = string, region = string
        })
    })
}

variable "environment" {
    type = object({
        metadata = object({
            sequence = string, primary_key = string, contact = string, source = string
        })
    })
}

variable "app_service" {
    type = list(object({
        service_plan = object({
            size = string
        }),
        scaling_plan = optional(object({
            cpu = object({
                max = number, min = number
            }),
            mem = object({
                max = number, min = number
            }),
        }))
        container = list(object({
            image = string,
            port = optional(number)
            enable_https = optional(bool)
        }))
    }))
    default = []
}