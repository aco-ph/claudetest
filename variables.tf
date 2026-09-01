variable "resource_group_name" {
  description = "Name of the resource group to create/use for the virtual networks and subnets."
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources into."
  type        = string
  default     = "uksouth"
}

variable "network_definitions_file" {
  description = "Path to the JSON file (relative to this module) listing vnets/subnets to create. One row per subnet: vnet_name, vnet_address_space, subnet_name, address_prefix."
  type        = string
  default     = "network.json"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
