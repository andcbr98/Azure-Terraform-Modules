variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = "test-rg"
}

variable "location" {
  description = "Azure region where resources will be deployed"
}

variable "lb_name" {
  description = "Load balancer name"
  default     = "mylb"
}

variable "frontend_ip_name" {
  description = "Name of the frontend IP configuration"
  default     = "PublicIPAddress"
}

variable "backend_pool_name" {
  description = "Backend pool name"
  default     = "backendPool1"
}

variable "backend_pool_count" {
  description = "Number of virtual machines to be added to the backend pool"
  type        = number
  default = 2
}

variable "backend_pool_vm_list" {
  description = "Names of virtual machines to be added to the backend pool"
  type        = list(string)
}
