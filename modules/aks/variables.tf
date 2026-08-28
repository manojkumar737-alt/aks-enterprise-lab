variable "cluster_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "node_count" {
  type = number
}

variable "acr_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}
