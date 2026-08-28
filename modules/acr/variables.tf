variable "acr_name" {

  description = "Azure Container Registry Name"

  type = string

}

variable "resource_group_name" {

  description = "Resource Group Name"

  type = string

}

variable "location" {

  description = "Azure Region"

  type = string

}

variable "sku" {

  description = "ACR SKU"

  type = string

}

variable "admin_enabled" {

  description = "Enable Admin User"

  type = bool

}

variable "tags" {

  description = "Common Tags"

  type = map(string)

}