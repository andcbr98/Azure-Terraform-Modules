variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = "test-rg"
}

variable "lb_name" {
  description = "Load balancer name"
  default     = "mylb"
}

variable "lb_sku" {
  description = "Load balancer sku"
  default     = "Standard"
}

variable "lb_sku_tier" {
  description = "Load balancer tier"
  default     = "Regional"
}

variable "frontend_ip_name" {
  description = "Name of the frontend IP configuration"
  default     = "PublicIPAddress"
}

variable "private_ip_address" {
  description = "Private IP address for NIC"
  type        = string
}

variable "backend_pool_name" {
  description = "Backend pool name"
  default     = "fortinet-bepool"
}

variable "backend_pool_count" {
  description = "Number of virtual machines to be added to the backend pool"
  type        = number
  default     = 2
}

variable "backend_pool_vm_list" {
  description = "Names of virtual machines to be added to the backend pool"
  type        = list(string)
}

variable "lb_rule_name" {
  description = "Load Balancer rule name"
  default     = "fortinet-berule"
}

variable "lb_rule_protocol" {
  description = "Load Balancer rule protocol"
  default     = "All"
}

variable "lb_rule_floating_ip" {
  description = "Load Balancer rule floating IP"
  default     = "true"
}

variable "lb_rule_tcp_reset" {
  description = "Load Balancer TCP reset"
  default     = "false"
}

variable "lb_rule_session" {
  description = "Load Balancer rule session type"
  default     = "SourceIP"
}

variable "health_probe_name" {
  description = "Health Probe name"
  default     = "fortinet-beprobe"
}

variable "health_probe_port" {
  description = "Load Balancer health probe port"
  default     = 80
}

variable "health_probe_protocol" {
  description = "Load Balancer health probe protocol"
  default     = "Http"
}