provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "azure_lb" {
  source = "../../../modules/load-balancer"

  resource_group_name  = var.resource_group_name
  location             = var.location
  lb_name              = var.lb_name
  frontend_ip_name     = var.frontend_ip_name
  backend_pool_name    = var.backend_pool_name
  backend_pool_count   = var.backend_pool_count
  backend_pool_vm_list = var.resource_prefixes
}