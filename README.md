# Azure Firewall
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/vpn/azurerm/)

Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.

## Version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| >= 1.x.x       | 0.14.x            |
| >= 1.x.x       | 0.13.x            |
| >= 1.x.x       | 0.12.x            |

## Resources

* Azure Firewall


## Configuration 

The follwoing Options are available to configure Azure Firewall

**SKU Configuration**

Below options are available for Azure Firewall .

```sku_name``` (Optional) Sku name of the Firewall. Possible values are ..

* AZFW_Hub 
* AZFW_VNet

```sku_tier``` (Optional) Sku tier of the Firewall. Possible values are
* Premium  
* Standard. 

**Threat intelligence Mode**

```threat_intel_mode``` - (Optional) The operation mode for threat intelligence-based filtering. Possible values are: 

* Off
* Alert
* Deny 
*  ""(empty string). 
**Defaults to Alert.**

**Rule Configuration**


## How to Use 

```hcl
module "firewall" {
  source  = ""
  version = "1.0.0"

  prefix = 
  project_prefix = 
  project = 
  environment = 
  location = 

  environment_owner = 
  environment_costcenter =
  environment_controller =



  
  }
```

## Deploy Resources  

**Initialize terraform module**

```sh
terraform init 
```
**Plan terraform module**

```sh
terraform plan 
```

**Deploy terraform module**

```sh
terraform apply 
```

## Destroy Resources 

**Destroy terraform module**

```sh
terraform destroy
``
