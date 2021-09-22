# Azure Firewall Network Rule

resource "azurerm_firewall_nat_rule_collection" "firewallnatrule" {
  name                = "${azurerm_firewall.firewall.name}NatRule"
  azure_firewall_name = var.fwName
  resource_group_name = var.resourceGroup
  priority            = 100
  action              = "Dnat"
  depends_on = [ azurerm_firewall.firewall]

  rule {
    name = "bastionNatRule"

    source_addresses = [
      "${var.allowed_source_ip}"
    ]

    destination_ports = [
      "22"
    ]

    destination_addresses = [
      "${data.azurerm_public_ip.firewallpip.ip_address}"
    ]

    protocols = [
      "TCP",
    ]

    translated_port = "22"

    translated_address = "${data.azurerm_lb.bastionlb_frontend_private_ip_address.private_ip_address}"
  }

  # rule {
    
  #   name = "rdpNatRule"

  #   source_addresses = [
  #     "${var.allowed_source_ip}"
  #   ]

  #   destination_ports = [
  #     "3389"
  #   ]

  #   destination_addresses = [
  #     "${data.azurerm_public_ip.firewallpip.ip_address}"
  #   ]

  #   protocols = [
  #     "TCP"
  #   ]

  #   translated_port = "3389"

  #   translated_address = "${var.security_frontend_private_ip_address}"
  # }
}
