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
  skip_provider_registration = true
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_network_interface" "this" {
  count               = var.backend_pool_count
  name                = "${var.backend_pool_vm_list[count.index]}-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
}


resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.lb_name}-ip"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name = var.backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  count                   = var.backend_pool_count
  network_interface_id    = data.azurerm_network_interface.this[count.index].id
  ip_configuration_name   = "${var.backend_pool_vm_list[count.index]}-ip"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}

output "lb_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}