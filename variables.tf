/*
   Variables for Azure Firewall module
*/


/**********************************************
Provider details
**********************************************/
variable "subscription_id" {
  description = "subscription id:"
}
variable "tenant_id" {
  description = "tenant id:"
}
variable "client_id" {
  description = "client id:"
}
variable "client_secret" {
  description = "client secret password:"
}


/************************************************
Global Variables
*************************************************/
variable "resourceGroup" {
  description = "Project Prefix:"
  default = "azResourceGroup"
}

variable "commonVnetName" {
  description = "Virtual Network Name for Firewall & Bastion:"
  default = "servicesVnet"
}

variable "location" {
  description = "Location:"
  default     = "westeurope"
}

variable "domain" {
  description = "Domain:"
}

variable "firewallpip" {
  description = "Public IP Name for security:"
  default = "firewallpip"
}

variable "fwName" {
  description = "Firewall Name:"
  default     = "azFirewall"
}

variable "lbName" {
  description = "Load Balancer name:"
}
/************************************************
Global Tags
*************************************************/
variable "environment_owner" {
  description = "Environment-owner Name:"
  default     = "ccoe"
}
variable "environment_costcenter" {
  description = "Environment-costcenter Name:"
  default     = "ccoe"
}
variable "environment_controller" {
  description = "Environment-controller Name:"
  default     = "ccoe"
}

/************************************************
Azure Firewall Variables
*************************************************/
/***** NAT Rule *******/

variable "firewall_sku_name" {
  description = "firewall_sku_name"
  default = "AZFW_VNet"
}

variable "firewall_sku_tier" {
  description = "firewall_sku_tier"
  default = "Standard"
}

variable "firewall_threat_intel_mode" {
  description = "firewall_threat_intel_mode"
  default = "Off"
}


variable "allowed_source_ip" {
  description = "Allowed source IP address for RDP and Bastion"
  default     = "0.0.0.0/0"
}

/***** Network Rule *******/
variable "network_cidr" {
  description = "Network CIDR to allow for TCP Protocol"
  default     = "10.0.0.0/20"
}
