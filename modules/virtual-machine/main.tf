provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "random_password" "vm_password" {
  length  = 16
  special = true
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.create_vnet ? 1 : 0
  name                = "${var.resource_prefixes[count.index]}-vnet"
  address_space       = [var.vnet_address_space]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "subnet" {
  count                = var.create_vnet ? var.subnet_count : 0
  name                 = element(var.subnet_names, count.index)
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [element(var.subnet_address_spaces, count.index)]
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.create_public_ip ? var.zone_count : 0
  name                = "${var.resource_prefixes[count.index]}-publicip-0${count.index + 1}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_network_interface" "nic" {
  count               = var.create_nic ? var.zone_count : 0
  name                = "${var.resource_prefixes[count.index]}-nic-0${count.index + 1}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.create_vnet ? azurerm_subnet.subnet[0].id : var.existent_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = element(var.private_ip_address, count.index)
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.public_ip[count.index].id : (var.existent_public_ip_id != "" ? var.existent_public_ip_id : null)
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_virtual_machine" "vm" {
  count                 = var.zone_count
  name                  = "${var.resource_prefixes[count.index]}-vm-0${count.index + 1}"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = var.create_nic ? [azurerm_network_interface.nic[count.index].id] : null

  vm_size = var.vm_size

  storage_image_reference {
    id        = var.custom_image_id
    publisher = var.custom_image_id == null ? var.vm_image_publisher : null
    offer     = var.custom_image_id == null ? var.vm_image_offer : null
    sku       = var.custom_image_id == null ? var.vm_image_sku : null
    version   = var.custom_image_id == null ? var.vm_image_version : null
  }

  storage_os_disk {
    name              = "${var.resource_prefixes[count.index]}-osdisk-0${count.index + 1}"
    caching           = var.os_disk_caching
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_type
    disk_size_gb      = var.os_disk_size_gb
  }
  
  os_profile {
    computer_name  = "${var.resource_prefixes[count.index]}-hostname-0${count.index + 1}"
    admin_username = var.admin_username
    admin_password = random_password.vm_password.result
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = var.enable_boot_diagnostics
    storage_uri = var.boot_diagnostics_storage_uri
  }

  dynamic "plan" {
    for_each = var.enable_plan ? ["one"] : []

    content {
      name      = var.vm_image_sku
      publisher = var.vm_image_publisher
      product   = var.vm_image_offer
    }
  }

  dynamic "storage_data_disk" {
    for_each = range(var.data_disk_count)
    content {
      name              = "${var.resource_prefixes[count.index]}-datadisk-0${count.index + 1}"
      lun               = storage_data_disk.value
      caching           = var.data_disk_caching
      create_option     = "Empty"
      disk_size_gb      = var.data_disk_size_gb
      managed_disk_type = var.data_disk_type
    }
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  zones = var.zone_redundant ? [count.index + 1] : null
}
