# Azure API Management Module

This module creates an Azure API Management (APIM) instance in a specified resource group.

## Usage

```hcl
module "api_management" {
  source              = "./path/to/module" 
  resource_group_name = "example-rg"       
  location            = "West Europe"
  apim_name           = "example-apim"
  publisher_name      = "Example Publisher"
  publisher_email     = "publisher@example.com"
  sku_name            = "Developer"
  identity_type       = "SystemAssigned"

  vnet_id    = "your-vnet-id"              
  subnet_id  = "your-subnet-id"            
  tags       = { environment = "dev" }
}

