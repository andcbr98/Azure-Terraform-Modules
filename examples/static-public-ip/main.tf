provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "public_ip" {
  source              = "../../modules/public-ip"
  name_prefix         = var.name_prefix
  name_suffix         = var.name_suffix
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  domain_name_label   = var.domain_name_label
}
