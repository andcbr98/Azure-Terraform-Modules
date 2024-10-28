variable "resource_group_name" {
  description = "Name of the existing Resource Group in which to create the APIM instance"
  type        = string
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
}

variable "apim_name" {
  description = "Name of the API Management instance"
  type        = string
}

variable "publisher_name" {
  description = "Publisher name for the API Management instance"
  type        = string
}

variable "publisher_email" {
  description = "Publisher email for the API Management instance"
  type        = string
}

variable "sku_name" {
  description = "SKU name for API Management instance (Developer, Basic, Standard, Premium)"
  type        = string
  default     = "Developer"
}

variable "identity_type" {
  description = "Type of identity for the API Management instance (None, SystemAssigned)"
  type        = string
  default     = "SystemAssigned"
}

variable "tags" {
  description = "Tags to apply to the API Management instance"
  type        = map(string)
  default     = {}
}

# variable "subnet_id" {
#   description = "ID of the existing Subnet where APIM will be deployed in internal mode"
#   type        = string
# }

# variable "vnet_id" {
#   description = "ID of the existing Virtual Network where the Subnet is located"
#   type        = string
# }
