# Terraform_Subnets

Provisions an Azure virtual network and one or more subnets.

## Structure

- `providers.tf` — Terraform and provider configuration
- `variables.tf` — input variable definitions
- `main.tf` — resource group, virtual network, and subnet resources
- `outputs.tf` — output values (resource group name, vnet ID, subnet IDs)
- `terraform.tfvars.example` — example variable values; copy to `terraform.tfvars` and edit

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your values

terraform init
terraform plan
terraform apply
```
