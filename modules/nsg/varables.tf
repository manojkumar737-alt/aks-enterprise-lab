variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Location"
  type        = string
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
}

variable "subnet_ids" {

  description = "Subnet IDs from Network Module"

  type = map(string)

}

variable "nsgs" {

  description = "NSG Configuration"

  type = map(object({

    subnet_name = string

    rules = list(object({

      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }))

  }))

}