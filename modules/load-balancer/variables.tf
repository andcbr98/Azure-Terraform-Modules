variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "test-rg"
}

variable "location" {
  description = "Azure region where resources will be deployed"
}

variable "lb_name" {
  description = "Name of the load balancer"
  default     = "mylb"
}

variable "frontend_ip_name" {
  description = "Name of the frontend IP configuration"
  default     = "PublicIPAddress"
}

variable "backend_pool_name" {
  description = "Name of the backend pool"
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
