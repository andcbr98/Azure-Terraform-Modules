variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}

variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "mydemo"
}

variable "create_vnet" {
  description = "Flag to create a virtual network"
  type        = bool
  default     = true
}

variable "create_public_ip" {
  description = "Flag to create a public IP"
  type        = bool
  default     = true
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

variable "vm_image_publisher" {
  description = "The publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "The offer of the VM image"
  type        = string
  default     = "UbuntuServer"
}

variable "vm_image_sku" {
  description = "The SKU of the VM image"
  type        = string
  default     = "18.04-LTS"
}

variable "vm_image_version" {
  description = "The version of the VM image"
  type        = string
  default     = "latest"
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
