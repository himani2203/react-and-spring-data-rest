variable "resource" {
    type = any
}

variable "capacity" {
    type = object({
        default = number
        maximum = number, minimum = number
    })
    default = {
        default = 1, maximum = 10, minimum = 1
    }
}

variable "cpu_percentage" {
    type = object({
        name = optional(string)
        max = number, min = number
    })
    default = {
        name = "CpuPercentage", max = 75, min = 25
    }
}

variable "mem_percentage" {
    type = object({
        name = optional(string)
        max = number, min = number
    })
    default = {
        name = "MemoryPercentage", max = 75, min = 25
    }
}

variable "notification" {
    type = object({
        email = list(string)
    })
    default = {
        email = []
    }
}

variable "tags" {
    type = map(string)
    default = {}
}