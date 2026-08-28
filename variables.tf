variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {

  type = map(object({
    address_prefixes = list(string)
  }))
}
variable "nsgs" {

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
variable "acr_name" {

  type = string

}

variable "acr_sku" {

  type = string

}

variable "admin_enabled" {

  type = bool

}
variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "node_count" {
  type = number
}

variable "vm_size" {
  type = string
}
variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}
