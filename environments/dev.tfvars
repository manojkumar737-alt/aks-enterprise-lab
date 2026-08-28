##subscription_id = "YOUR_SUBSCRIPTION_ID"
resource_group_name = "rg-aks-dev"
location            = "eastus"
tags = {
  Environment = "Dev"
  Project     = "AKS"
  Owner       = "Manoj"
}
vnet_name = "vnet-aks-dev"

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
nsgs = {

  aks-nsg = {

    subnet_name = "aks-subnet"

    rules = [

      {

        name = "AllowHTTPS"

        priority = 100

        direction = "Inbound"

        access = "Allow"

        protocol = "Tcp"

        source_port_range = "*"

        destination_port_range = "443"

        source_address_prefix = "*"

        destination_address_prefix = "*"

      }

    ]

  }

  appgw-nsg = {

    subnet_name = "appgw-subnet"

    rules = [

      {

        name = "AllowHTTP"

        priority = 100

        direction = "Inbound"

        access = "Allow"

        protocol = "Tcp"

        source_port_range = "*"

        destination_port_range = "80"

        source_address_prefix = "*"

        destination_address_prefix = "*"

      },

      {

        name = "AllowHTTPS"

        priority = 110

        direction = "Inbound"

        access = "Allow"

        protocol = "Tcp"

        source_port_range = "*"

        destination_port_range = "443"

        source_address_prefix = "*"

        destination_address_prefix = "*"

      }

    ]

  }

  management-nsg = {

    subnet_name = "management-subnet"

    rules = [

      {

        name = "AllowSSH"

        priority = 100

        direction = "Inbound"

        access = "Allow"

        protocol = "Tcp"

        source_port_range = "*"

        destination_port_range = "22"

        source_address_prefix = "*"

        destination_address_prefix = "*"

      }

    ]

  }

}
acr_name = "manojaksdevacr"

acr_sku = "Basic"

admin_enabled = false
cluster_name  = "aks-dev"

dns_prefix = "aks-dev"

kubernetes_version = "1.35"

vm_size = "Standard_D2s_v3"

node_count   = 1
service_cidr = "10.240.0.0/16"

dns_service_ip = "10.240.0.10"

