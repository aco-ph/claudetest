variable "resource_group_name" {
  description = "Name of the resource group to create/use for the virtual network and subnets."
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources into."
  type        = string
  default     = "uksouth"
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create within the virtual network."
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
