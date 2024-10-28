provider "azurerm" {
  features {}
}

# API Management Service in Internal Mode
resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name 
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name

  #virtual_network_configuration {
  #  subnet_id = var.subnet_id
  #}

  #virtual_network_type = "Internal" # Set APIM in Internal Mode

  identity {
    type = var.identity_type
  }
  
  tags = var.tags
}
