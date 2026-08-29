module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}
module "network" {

  source = "./modules/network"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  vnet_name     = var.vnet_name
  address_space = var.address_space
  subnets       = var.subnets

  tags = var.tags
}
module "nsg" {

  source = "./modules/nsg"

  resource_group_name = module.resource_group.name

  location = module.resource_group.location

  subnet_ids = module.network.subnet_ids

  tags = var.tags

  nsgs = var.nsgs

}
#module "acr" {
#
#  source = "./modules/acr"
#
#  acr_name = var.acr_name
#
#  resource_group_name = module.resource_group.name
#
#  location = module.resource_group.location
#
#  sku = var.acr_sku
#
#  admin_enabled = var.admin_enabled
#
#  tags = var.tags
#
#}
module "aks" {

  source = "./modules/aks"

  cluster_name = var.cluster_name

  resource_group_name = module.resource_group.name

  location = module.resource_group.location

  dns_prefix = var.dns_prefix

  subnet_id = module.network.subnet_ids["aks-subnet"]

  kubernetes_version = var.kubernetes_version

  vm_size = var.vm_size

  node_count = var.node_count

  #acr_id = module.acr.id

  tags           = var.tags
  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip

}