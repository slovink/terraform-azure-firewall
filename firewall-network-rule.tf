# Azure Firewall Network Rule

resource "azurerm_firewall_network_rule_collection" "firewallnetrule" {
  name                = "${azurerm_firewall.firewall.name}NetRule"
  azure_firewall_name = var.fwName
  resource_group_name = var.resourceGroup
  priority            = 800
  action              = "Allow"
  depends_on = [azurerm_firewall_nat_rule_collection.firewallnatrule ]
  rule {
    name = "netRule"

    source_addresses = [
      "${var.network_cidr}"
    ]

    destination_ports = [
      "*"
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "TCP"
    ]
  }

  
}

# resource "azurerm_firewall_network_rule_collection" "firewallwafrule" {
#   name                = "${var.project_prefix}-${var.project}-firewallwafrule"
#   azure_firewall_name = "${var.project_prefix}-${var.project}-firewall"
#   resource_group_name = "${var.project_prefix}_${var.project}_${var.environment}"
#   priority            = 200
#   action              = "Allow"
#   depends_on = [azurerm_firewall_nat_rule_collection.firewallnatrule ]
  

#   rule {
#     name = "wafNetRule"

#     source_addresses = [
#       "${data.azurerm_public_ip.firewallpip.ip_address}"
#     ]

#     destination_ports = [
#       "80"
#     ]

#     destination_addresses = [
#       "${data.azurerm_public_ip.wafip.ip_address}"
#     ]

#     protocols = [
#       "TCP"
#     ]
#   }
# }

