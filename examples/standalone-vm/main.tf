provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "azure_vm" {
  source = "../../modules/vm"

  resource_group_name          = var.resource_group_name
  name_prefix                  = var.name_prefix
  vnet_address_space           = var.vnet_address_space
  subnet_count                 = var.subnet_count
  subnet_names                 = var.subnet_names
  subnet_address_spaces        = var.subnet_address_spaces
  create_vnet                  = var.create_vnet
  create_public_ip             = var.create_public_ip
  create_nic                   = var.create_nic
  zone_count                   = var.zone_count
  vm_size                      = var.vm_size
  os_disk_caching              = var.os_disk_caching
  os_disk_type                 = var.os_disk_type
  os_disk_size_gb              = var.os_disk_size_gb
  vm_image_publisher           = var.vm_image_publisher
  vm_image_offer               = var.vm_image_offer
  vm_image_sku                 = var.vm_image_sku
  vm_image_version             = var.vm_image_version
  admin_username               = var.admin_username
  enable_boot_diagnostics      = var.enable_boot_diagnostics
  boot_diagnostics_storage_uri = var.boot_diagnostics_storage_uri
  data_disk_count              = var.data_disk_count
  data_disk_caching            = var.data_disk_caching
  data_disk_size_gb            = var.data_disk_size_gb
  data_disk_type               = var.data_disk_type
  zone_redundant               = var.zone_redundant
}
