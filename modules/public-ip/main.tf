provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name_prefix}-${var.name_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  domain_name_label = var.domain_name_label
    

  tags = {}

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
