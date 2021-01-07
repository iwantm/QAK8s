provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "k8-resources" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "clust" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.k8-resources.location
  resource_group_name = azurerm_resource_group.k8-resources.name
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name       = "default"
    node_count = var.nodeCount
    vm_size    = var.sku
  }

  identity {
    type = "SystemAssigned"
  }
}