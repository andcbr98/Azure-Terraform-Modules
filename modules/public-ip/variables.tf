variable "name_prefix" {
  description = "Prefix to use"
  type        = string
  default     = "demo"
}

variable "name_suffix" {
  description = "Suffix to use"
  type        = string
  default     = "demo"
}

variable "location" {
  description = "Location to use"
  type        = string
  default     = "Italy North"
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = "test-rg"
}

variable "allocation_method" {
  description = "The allocation method for the Public IP"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "The SKU of the Public IP"
  type        = string
  default     = "Basic"
}

variable "domain_name_label" {
  description = "The Domain Name Label for the Public IP"
  type        = string
  default     = null
}
