provider "azurerm" {
  features {}
}

resource "random_password" "vm_password" {
  length  = 16
  special = true
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  count = var.create_vnet ? 1 : 0
  name                = "${var.name_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  count = var.create_vnet ? 1 : 0
  name                 = "${var.name_prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  count = var.create_public_ip ? var.zone_count : 0
  name                = "${var.name_prefix}-publicip-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  count = var.create_nic ? var.zone_count : 0
  name                = "${var.name_prefix}-nic-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.${count.index + 4}"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.public_ip[count.index].id : null
  }
}

resource "azurerm_virtual_machine" "vm" {
  count                 = var.zone_count
  name                  = "${var.name_prefix}-vm-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = var.create_nic ? [azurerm_network_interface.nic[count.index].id] : []

  vm_size = var.vm_size

  storage_os_disk {
    name              = "${var.name_prefix}-osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  os_profile {
    computer_name  = "${var.name_prefix}-hostname-${count.index}"
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

  dynamic "storage_data_disk" {
    for_each = range(var.data_disk_count)
    content {
      name              = "${var.name_prefix}-datadisk-${count.index}-${storage_data_disk.value}"
      lun               = storage_data_disk.value
      caching           = "ReadWrite"
      create_option     = "Empty"
      disk_size_gb      = var.data_disk_size_gb
      managed_disk_type = var.data_disk_type
    }
  }

  zone = var.zone_redundant ? count.index + 1 : null
}
