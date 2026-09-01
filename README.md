# Terraform_Subnets

Provisions one or more Azure virtual networks and their subnets, driven by
a data file listing every subnet.

## Structure

- `providers.tf` — Terraform and provider configuration
- `variables.tf` — input variable definitions
- `main.tf` — resource group, virtual network(s), and subnet resources
- `outputs.tf` — output values (resource group name, vnet IDs, subnet IDs)
- `terraform.tfvars.example` — example variable values; copy to `terraform.tfvars` and edit
- `network.json.example` — example vnet/subnet data; copy to `network.json` and edit

## Defining vnets and subnets

`network.json` is a flat list, one row per subnet:

```json
[
  { "vnet_name": "vnet-prod", "vnet_address_space": ["10.0.0.0/16"], "subnet_name": "snet-app",  "address_prefix": "10.0.1.0/24" },
  { "vnet_name": "vnet-prod", "vnet_address_space": ["10.0.0.0/16"], "subnet_name": "snet-data", "address_prefix": "10.0.2.0/24" },
  { "vnet_name": "vnet-dev",  "vnet_address_space": ["10.1.0.0/16"], "subnet_name": "snet-app",  "address_prefix": "10.1.1.0/24" }
]
```

`main.tf` groups the rows by `vnet_name` to create each distinct virtual
network, then creates one subnet per row inside its parent vnet. Add as
many rows as you need — for another subnet, add a row; for another vnet,
add rows with a new `vnet_name`. All rows sharing a `vnet_name` must use
the same `vnet_address_space`.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
cp network.json.example network.json
# edit both files with your values

terraform init
terraform plan
terraform apply
```
