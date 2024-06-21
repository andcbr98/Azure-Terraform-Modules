variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "test-rg"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "Italy North"
}

variable "resource_prefixes" {
  description = "Prefix for all resources/List of virtual machine names"
  type        = list(string)
  default     = ["vm1", "vm2"]
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
  default     = 2
}