variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "soa_record" {
  type = object({
    email        = string
    expire_time  = optional(number)
    minimum_ttl  = optional(number)
    refresh_time = optional(number)
    retry_time   = optional(number)
    ttl          = optional(number)
    tags         = optional(map(string))
  })
  default = null
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "virtual_network_link" {
  type = map(object({
    name                  = string
    private_dns_zone_name = optional(string)
    resource_group_name   = optional(string)
    virtual_network_id    = string
    registration_enabled  = bool
    tags                  = optional(map(string))
  }))
  default = null
}