resource "azurerm_firewall" "firewall" {
  name                     = var.fwName
  resource_group_name      = var.resourceGroup
  location                 = var.location
  sku_name                 = var.firewall_sku_name
  sku_tier                 = var.firewall_sku_tier
  threat_intel_mode        = var.firewall_threat_intel_mode


  ip_configuration {
  name                 = "fwConfiguration"
  subnet_id            = "${data.azurerm_subnet.firewallsubnet.id}"
  public_ip_address_id = "${data.azurerm_public_ip.firewallpip.id}"
  }

  tags = local.resourceTags

}
