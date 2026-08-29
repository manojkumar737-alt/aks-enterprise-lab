resource "azurerm_kubernetes_cluster" "this" {

  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  kubernetes_version = var.kubernetes_version
  sku_tier           = "Free"
  node_provisioning_profile {
    mode = "Manual"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  local_account_disabled = false

  role_based_access_control_enabled = true

  default_node_pool {

    name = "system"

    node_count = var.node_count

    vm_size = var.vm_size

    vnet_subnet_id = var.subnet_id

    os_disk_size_gb = 30

    type = "VirtualMachineScaleSets"

  }

  identity {

    type = "SystemAssigned"

  }

  linux_profile {

    admin_username = "azureuser"

    ssh_key {

      key_data = file("~/.ssh/id_rsa.pub")

    }

  }

  network_profile {

    network_plugin = "azure"

    network_policy = "azure"

    network_data_plane = "azure"

    load_balancer_sku = "standard"

    service_cidr = var.service_cidr

    dns_service_ip = var.dns_service_ip

  }
}
#resource "azurerm_role_assignment" "acr_pull" {
#
#  scope = var.acr_id
#
#  role_definition_name = "AcrPull"
#
# principal_id = azurerm_kubernetes_cluster.this.identity[0].principal_id
#
#}