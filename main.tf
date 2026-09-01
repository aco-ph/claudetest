locals {
  # One row per subnet: { vnet_name, vnet_address_space, subnet_name, address_prefix }
  network_records = jsondecode(file("${path.module}/${var.network_definitions_file}"))

  # Group rows by vnet_name to derive the distinct set of vnets and their address space.
  # All rows for the same vnet must carry the same vnet_address_space; the first is used.
  vnets_grouped = { for r in local.network_records : r.vnet_name => r.vnet_address_space... }
  vnets         = { for name, spaces in local.vnets_grouped : name => spaces[0] }

  # Flatten subnets into a map keyed by "<vnet_name>.<subnet_name>" so each subnet can
  # look up its parent vnet.
  subnets = { for r in local.network_records : "${r.vnet_name}.${r.subnet_name}" => r }
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  for_each = local.vnets

  name                = each.key
  address_space       = each.value
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_name].name
  address_prefixes     = [each.value.address_prefix]
}
