# Data block for Firewall Subnet
data "azurerm_subnet" "firewallsubnet" {
  name                   = "AzureFirewallSubnet"
  resource_group_name    = var.resourceGroup
  virtual_network_name   = var.commonVnetName
}

data "azurerm_public_ip" "firewallpip" {
  name                     = var.firewallpip
  resource_group_name      = var.resourceGroup
}

data "azurerm_lb" "bastionlb_frontend_private_ip_address" {
  name                 = var.lbName
  resource_group_name  = var.resourceGroup
}