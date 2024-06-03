resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name_prefix}-publicip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method   = var.allocation_method
  sku                 = var.sku

  dynamic "dns_settings" {
    for_each = var.domain_name_label != null ? [1] : []
    content {
      domain_name_label = var.domain_name_label
    }
  }

  tags = {}
  
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
