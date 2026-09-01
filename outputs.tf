output "resource_group_name" {
  description = "Name of the resource group."
  value       = azurerm_resource_group.this.name
}

output "vnet_ids" {
  description = "Map of vnet names to their resource IDs."
  value       = { for name, vnet in azurerm_virtual_network.this : name => vnet.id }
}

output "subnet_ids" {
  description = "Map of \"<vnet_name>.<subnet_name>\" to their resource IDs."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}
