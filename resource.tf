resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  dynamic "soa_record" {
    for_each = var.soa_record != null ? [var.soa_record] : []
    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
      tags         = soa_record.value.tags
    }
  }
  tags = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link" {
  for_each              = var.virtual_network_link != null ? { for k, v in var.virtual_network_link : k => v if v != null } : {}
  name                  = each.value.name
  private_dns_zone_name = lookup(each.value, "private_dns_zone_name", null) != null ? lookup(each.value, "private_dns_zone_name", null) : azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name   = lookup(each.value, "resource_group_name", null) != null ? lookup(each.value, "resource_group_name", null) : azurerm_private_dns_zone.private_dns_zone.resource_group_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
  tags                  = lookup(each.value, "tags", null)
}