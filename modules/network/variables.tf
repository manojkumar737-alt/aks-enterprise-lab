variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "address_space" {
  description = "VNet Address Space"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet Configuration"

  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}