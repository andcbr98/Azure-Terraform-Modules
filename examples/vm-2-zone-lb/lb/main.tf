provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "azure_lb" {
  source = "../../../modules/load-balancer"

  resource_group_name   = var.resource_group_name
  location              = var.location
  lb_name               = var.lb_name
  lb_sku                = var.lb_sku
  lb_sku_tier           = var.lb_sku_tier
  frontend_ip_name      = var.frontend_ip_name
  private_ip_address    = var.private_ip_address
  backend_pool_name     = var.backend_pool_name
  backend_pool_count    = var.backend_pool_count
  backend_pool_vm_list  = var.resource_prefixes
  lb_rule_name          = var.lb_rule_name
  lb_rule_protocol      = var.lb_rule_protocol
  lb_rule_floating_ip   = var.lb_rule_floating_ip
  lb_rule_tcp_reset     = var.lb_rule_tcp_reset
  lb_rule_session       = var.lb_rule_session
  health_probe_name     = var.health_probe_name
  health_probe_port     = var.health_probe_port
  health_probe_protocol = var.health_probe_protocol
}