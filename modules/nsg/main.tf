resource "azurerm_network_security_group" "this" {

  for_each = var.nsgs

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags

  dynamic "security_rule" {

    for_each = each.value.rules

    content {

      name      = security_rule.value.name
      priority  = security_rule.value.priority
      direction = security_rule.value.direction
      access    = security_rule.value.access
      protocol  = security_rule.value.protocol

      source_port_range      = security_rule.value.source_port_range
      destination_port_range = security_rule.value.destination_port_range

      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }

  }

}

resource "azurerm_subnet_network_security_group_association" "this" {

  for_each = var.nsgs

  subnet_id = var.subnet_ids[each.value.subnet_name]

  network_security_group_id = azurerm_network_security_group.this[each.key].id

}