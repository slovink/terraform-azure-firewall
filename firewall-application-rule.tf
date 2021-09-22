# Azure Firewall Application Rule

resource "azurerm_firewall_application_rule_collection" "firewallapprule" {
  name                = "${azurerm_firewall.firewall.name}AppRule"
  azure_firewall_name = var.fwName
  resource_group_name = var.resourceGroup
  priority            = 300
  action              = "Allow"

  rule {
    name = "applicationRule"

    source_addresses = [
      "*"
    ]

    target_fqdns = [
      "*.${var.domain}"
    ]

    protocol {
       port= "80"
       type = "Http"
    }
  }
}
