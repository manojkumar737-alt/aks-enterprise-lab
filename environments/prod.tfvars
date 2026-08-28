##subscription_id = "YOUR_SUBSCRIPTION_ID"
resource_group_name = "rg-aks-prod"
location            = "Central India"
tags = {
  Environment = "PROD"
  Project     = "AKS"
  Owner       = "Manoj"
}
vnet_name = "vnet-aks-prod"

address_space = [
  "10.0.0.0/16"
]

subnets = {

  aks-subnet = {
    address_prefixes = ["10.0.1.0/24"]
  }

  appgw-subnet = {
    address_prefixes = ["10.0.2.0/24"]
  }

  management-subnet = {
    address_prefixes = ["10.0.3.0/24"]
  }

}
acr_name = "manojaksprodacr"

acr_sku = "Basic"

admin_enabled = false
cluster_name  = "aks-prod"

dns_prefix = "aks-prod"

kubernetes_version = "1.35"

vm_size = "Standard_B2s"

node_count = 1