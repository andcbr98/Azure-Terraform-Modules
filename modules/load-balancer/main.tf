terraform {
  required_version = ">= 0.14.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_network_interface" "this" {
  count               = var.backend_pool_count
  name                = "${var.backend_pool_vm_list[count.index]}-inside-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = var.lb_sku
  sku_tier            = var.lb_sku_tier

  frontend_ip_configuration {
    name                          = var.frontend_ip_name
    subnet_id                     = "/subscriptions/<subscription-id>/resourceGroups/fortinet-rg/providers/Microsoft.Network/virtualNetworks/fortinet-vnet/subnets/default"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
  }
}

resource "azurerm_lb_rule" "this" {
  name                           = var.lb_rule_name
  loadbalancer_id                = azurerm_lb.this.id
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
  protocol                       = var.lb_rule_protocol
  frontend_port                  = 0
  backend_port                   = 0
  idle_timeout_in_minutes        = 4
  enable_floating_ip             = var.lb_rule_floating_ip
  enable_tcp_reset               = var.lb_rule_tcp_reset
  load_distribution              = var.lb_rule_session
}

resource "azurerm_lb_probe" "this" {
  name                = var.health_probe_name
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = var.health_probe_protocol
  port                = var.health_probe_port
  request_path        = "/health"
  interval_in_seconds = 5
  number_of_probes    = 2
}


resource "azurerm_lb_backend_address_pool" "this" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count                   = var.backend_pool_count
  network_interface_id    = data.azurerm_network_interface.this[count.index].id
  ip_configuration_name   = "${var.backend_pool_vm_list[count.index]}-inside-ip"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}