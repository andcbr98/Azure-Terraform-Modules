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
  description = "Prefix for all resources"
  type        = list(string)
  default     = ["demo"]
}

variable "create_vnet" {
  description = "Flag to create a virtual network"
  type        = bool
  default     = true
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "The number of subnets to create"
  type        = number
  default     = 1
}

variable "subnet_names" {
  description = "The names of the subnets"
  type        = list(string)
  default     = ["subnet1"]
}

variable "subnet_address_spaces" {
  description = "The address spaces for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "create_public_ip" {
  description = "Flag to create a public IP"
  type        = bool
  default     = true
}

variable "existent_vnet_id" {
  description = "ID of an existing virtual network to use"
  type        = string
  default     = ""
}

variable "existent_subnet_id" {
  description = "ID of an existing subnet to use"
  type        = string
  default     = ""
}

variable "existent_public_ip_id" {
  description = "ID of an existing public ip to use"
  type        = string
  default     = ""
}

variable "private_ip_address" {
  description = "List of private ip address to use"
  type        = list(string)
  default     = ["10.0.1.6"]
}

variable "create_nic" {
  description = "Flag to create a network interface"
  type        = bool
  default     = true
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
  default     = "adminuser"
}

variable "enable_boot_diagnostics" {
  description = "Enable boot diagnostics for the virtual machine"
  type        = bool
  default     = false
}

variable "boot_diagnostics_storage_uri" {
  description = "URI of the storage account for boot diagnostics"
  type        = string
  default     = ""
}

variable "enable_plan" {
  description = "Enable usage of the Offer/Plan on Azure Marketplace. Can be set to `false` when using a custom image."
  default     = true
  type        = bool
}

variable "custom_image_id" {
  description = "Absolute ID of Custom Image to use."
  default     = null
  type        = string
}

variable "vm_image_publisher" {
  description = "The publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "The offer of the VM image"
  type        = string
  default     = "0001-com-ubuntu-server-focal"
}

variable "vm_image_sku" {
  description = "The SKU of the VM image"
  type        = string
  default     = "20_04-lts-gen2"
}

variable "vm_image_version" {
  description = "The version of the VM image"
  type        = string
  default     = "latest"
}

variable "os_disk_caching" {
  description = "The caching mode of the OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_type" {
  description = "The type of the OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB"
  type        = number
  default     = 30
}

variable "data_disk_count" {
  description = "The number of data disks to attach to the VM"
  type        = number
  default     = 1
}

variable "data_disk_size_gb" {
  description = "The size of each data disk in GB"
  type        = number
  default     = 32
}

variable "data_disk_type" {
  description = "The type of the data disk"
  type        = string
  default     = "Standard_LRS"
}

variable "data_disk_caching" {
  description = "The caching mode of the data disk"
  type        = string
  default     = "ReadWrite"
}

variable "zone_redundant" {
  description = "Flag to enable zone redundancy"
  type        = bool
  default     = false
}

variable "zone_count" {
  description = "The number of availability zones to use"
  type        = number
  default     = 1
}