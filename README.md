# terraform-azure-firewall
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This module provides a Terraform configuration for deploying various Azure resources as part of your infrastructure. The configuration includes the deployment of resource groups, virtual networks, subnets, firewall.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: complete

```hcl
module "firewall" {
  depends_on          = [module.name_specific_subnet]
  source              = "git::https://github.com/slovink/terraform-azure-firewall.git?ref=v1.0.0"
  name                = local.name
  environment         = local.environment
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  subnet_id           = module.name_specific_subnet.specific_subnet_id
  public_ip_names     = ["ingress", "vnet"] // Name of public ips you want to create.
  firewall_enable     = true
  policy_rule_enabled = true
  application_rule_collection = [
    {
      name     = "example_app_policy"
      priority = 200
      action   = "Allow"
      rules = [
        {
          name              = "app_test"
          source_addresses  = ["*"] // ["X.X.X.X"]
          destination_fqdns = ["*"] // ["X.X.X.X"]
          protocols = [
            {
              port = "443"
              type = "Https"
            },
            {
              port = "80"
              type = "Http"
            }
          ]
        }
      ]
    }
  ]

  network_rule_collection = [
    {
      name     = "example_network_policy"
      priority = "100"
      action   = "Allow"
      rules = [
        {
          name                  = "ssh"
          protocols             = ["TCP"]
          source_addresses      = ["*"] // ["X.X.X.X"]
          destination_addresses = ["*"] // ["X.X.X.X"]
          destination_ports     = ["22"]
        }

      ]
    },
    {
      name     = "example_network_policy-2"
      priority = "101"
      action   = "Allow"
      rules = [
        {
          name                  = "smtp"
          protocols             = ["TCP"]
          source_addresses      = ["*"] // ["X.X.X.X"]
          destination_addresses = ["*"] // ["X.X.X.X"]
          destination_ports     = ["587"]
        }
      ]
    }
  ]

  nat_rule_collection = [
    {
      name     = "example_nat_policy-1"
      priority = "101"
      rules = [
        {
          name                = "http"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["80"]
          source_addresses    = ["*"]
          translated_port     = "80"
          translated_address  = "10.1.1.1"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[1] //Public ip associated with firewall. Here index 1 indicates 'vnet ip' (from public_ip_names     = ["ingress" , "vnet"])

        },
        {
          name                = "https"
          protocols           = ["TCP"]
          destination_ports   = ["443"]
          source_addresses    = ["*"]
          translated_port     = "443"
          translated_address  = "10.1.1.1"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[1] //Public ip associated with firewall

        }
      ]
    },

    {
      name     = "example-nat-policy-2"
      priority = "100"
      rules = [
        {
          name                = "http"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["80"]
          translated_port     = "80"
          translated_address  = "10.1.1.2"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[0] //Public ip associated with firewall.Here index 0 indicates 'ingress ip' (from public_ip_names     = ["ingress" , "vnet"])

        },
        {
          name                = "https"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["443"]
          translated_port     = "443"
          translated_address  = "10.1.1.2"
          destination_address = module.firewall.public_ip_address[0]
        }
      ]
    }
  ]
}
```

# Example: firewall-with-isolated-rules

```hcl
module "firewall-rules" {
  depends_on          = [module.firewall]
  source              = "git::https://github.com/slovink/terraform-azure-firewall.git?ref=v1.0.0"
  name                = local.name
  environment         = local.environment
  policy_rule_enabled = true
  firewall_policy_id  = module.firewall.firewall_policy_id
  application_rule_collection = [
    {
      name     = "example_app_policy"
      priority = 200
      action   = "Allow"
      rules = [
        {
          name              = "app_test"
          source_addresses  = ["*"] // ["X.X.X.X"]
          destination_fqdns = ["*"] // ["X.X.X.X"]
          protocols = [
            {
              port = "443"
              type = "Https"
            },
            {
              port = "80"
              type = "Http"
            }
          ]
        }
      ]
    }
  ]
  network_rule_collection = [
    {
      name     = "example_network_policy"
      priority = "100"
      action   = "Allow"
      rules = [
        {
          name                  = "ssh"
          protocols             = ["TCP"]
          source_addresses      = ["*"] // ["X.X.X.X"]
          destination_addresses = ["*"] // ["X.X.X.X"]
          destination_ports     = ["22"]
        }

      ]
    },
    {
      name     = "example_network_policy-2"
      priority = "101"
      action   = "Allow"
      rules = [
        {
          name                  = "smtp"
          protocols             = ["TCP"]
          source_addresses      = ["*"] // ["X.X.X.X"]
          destination_addresses = ["*"] // ["X.X.X.X"]
          destination_ports     = ["587"]
        }
      ]
    }
  ]

  nat_rule_collection = [
    {
      name     = "example_nat_policy-1"
      priority = "101"
      rules = [
        {
          name                = "http"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["80"]
          source_addresses    = ["*"]
          translated_port     = "80"
          translated_address  = "10.1.1.1"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[1] //Public ip associated with firewall. Here index 1 indicates 'vnet ip' (from public_ip_names     = ["ingress" , "vnet"])

        },
        {
          name                = "https"
          protocols           = ["TCP"]
          destination_ports   = ["443"]
          source_addresses    = ["*"]
          translated_port     = "443"
          translated_address  = "10.1.1.1"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[1] //Public ip associated with firewall

        }
      ]
    },
    {
      name     = "example-nat-policy-2"
      priority = "100"
      rules = [
        {
          name                = "http"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["80"]
          translated_port     = "80"
          translated_address  = "10.1.1.2"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[0] //Public ip associated with firewall.Here index 0 indicates 'ingress ip' (from public_ip_names     = ["ingress" , "vnet"])

        },
        {
          name                = "https"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["443"]
          translated_port     = "443"
          translated_address  = "10.1.1.2"                           #provide private ip address to translate
          destination_address = module.firewall.public_ip_address[0] //Public ip associated with firewall
        }
      ]
    }
  ]
}

```
# Example: firewall-with-public-ip-prefix

```hcl
module "firewall" {
  depends_on              = [module.name_specific_subnet]
  source                  = "git::https://github.com/slovink/terraform-azure-firewall.git?ref=v1.0.0"
  name                    = local.name
  environment             = local.environment
  resource_group_name     = module.resource_group.resource_group_name
  location                = module.resource_group.resource_group_location
  subnet_id               = module.name_specific_subnet.specific_subnet_id
  public_ip_prefix_enable = true
  prefix_public_ip_names  = ["test-1", "test-2"]
  public_ip_prefix_length = 31
  enable_prefix_subnet    = true
  firewall_enable     = true
  policy_rule_enabled = true
  application_rule_collection = [
    {
      name     = "example_app_policy"
      priority = 200
      action   = "Allow"
      rules = [
        {
          name              = "app_test"
          source_addresses  = ["*"] // ["X.X.X.X"]
          destination_fqdns = ["*"] // ["X.X.X.X"]
          protocols = [
            {
              port = "443"
              type = "Https"
            },
            {
              port = "80"
              type = "Http"
            }
          ]
        }
      ]
    }
  ]

  network_rule_collection = [
    {
      name     = "example_network_policy"
      priority = "100"
      action   = "Allow"
      rules = [
        {
          name                  = "ssh"
          protocols             = ["TCP"]
          source_addresses      = ["*"] // ["X.X.X.X"]
          destination_addresses = ["*"] // ["X.X.X.X"]
          destination_ports     = ["22"]
        }

      ]
    },
    {
      name     = "example_network_policy-2"
      priority = "101"
      action   = "Allow"
      rules = [
        {
          name                  = "smtp"
          protocols             = ["TCP"]
          source_addresses      = ["*"] // ["X.X.X.X"]
          destination_addresses = ["*"] // ["X.X.X.X"]
          destination_ports     = ["587"]
        }
      ]
    }
  ]

  nat_rule_collection = [
    {
      name     = "example_nat_policy-1"
      priority = "101"
      rules = [
        {
          name                = "http"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["80"]
          source_addresses    = ["*"]
          translated_port     = "80"
          translated_address  = "10.1.1.1"                                  #provide private ip address to translate
          destination_address = module.firewall.prefix_public_ip_address[1] //Public ip associated with firewall. Here index 1 indicates 'vnet ip' (from public_ip_names     = ["ingress" , "vnet"])

        },
        {
          name                = "https"
          protocols           = ["TCP"]
          destination_ports   = ["443"]
          source_addresses    = ["*"]
          translated_port     = "443"
          translated_address  = "10.1.1.1"                                  #provide private ip address to translate
          destination_address = module.firewall.prefix_public_ip_address[1] //Public ip associated with firewall

        }
      ]
    },

    {
      name     = "example-nat-policy-2"
      priority = "100"
      rules = [
        {
          name                = "http"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["80"]
          translated_port     = "80"
          translated_address  = "10.1.1.2"                                  #provide private ip address to translate
          destination_address = module.firewall.prefix_public_ip_address[0] //Public ip associated with firewall.Here index 0 indicates 'ingress ip' (from public_ip_names     = ["ingress" , "vnet"])

        },
        {
          name                = "https"
          protocols           = ["TCP"]
          source_addresses    = ["*"] // ["X.X.X.X"]
          destination_ports   = ["443"]
          translated_port     = "443"
          translated_address  = "10.1.1.2"                                  #provide private ip address to translate
          destination_address = module.firewall.prefix_public_ip_address[0] //Public ip associated with firewall
        }
      ]
    }
  ]
}
```

This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
- 'name': Specifies the name of the Firewall.
- 'resource_group_name': The name of the resource group in which to create the resource.
- 'location': Specifies the supported Azure location where the resource exists.
- 'subnet_id': Reference to the subnet associated with the IP Configuration.

## Module Outputs
- 'firewall_id': The ID of the Azure Firewall.

## Examples
For detailed examples on how to use this module, please refer to the '[examples](https://github.com/slovink/terraform-azure-firewall/blob/krishna/_example)' directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/slovink/terraform-azure-firewall/blob/krishna/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
