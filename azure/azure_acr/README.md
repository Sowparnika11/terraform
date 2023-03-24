# Azure Container Registry Service
![status](https://img.shields.io/badge/Status-approved%20(2022--10--10)-success)


Azure Container Registry allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. Use Azure container registries with your existing container development and deployment pipelines. Use Azure Container Registry Tasks to build container images in Azure on-demand, or automate builds triggered by source code updates, updates to a container's base image, or timers. 



## Usage
Run from local paths
### Prerequisite
- install terraform binary 
- Install and Login in to cloud CLI
- required permission to run and create modules. 

### Steps
- Create folder in local drive and copy the min-params.tf or max-params.tf. 
- Modify the vaules based on the project requirement.
-  You can start with min-params.tf or max-params.tf based on the project needs. change the values and soruce repo URL and run the below  terraform commands. 

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Examples
- With minimum parameters
```hcl
module "project_name_ACR" {
  source              = "../azure_acr/code/"
  resource_group_name = "existingRG"
  acr_name            = "acr0011w"
}
```

- With maximum parameters

```hcl
module "project_name_ACR" {
  source                        = "../azure_acr/code/"
  create_resource_group         = true
  resource_group_name           = "acr"
  location                      = "Northeurope"
  acr_name                      = "acr0011w"
  acr_sku                       = "Premium"
  public_network_access_enabled = false
  quarantine_policy_enabled     = false
  zone_redundancy_enabled       = true
  georeplications = [
    { location = "uksouth"
    enabled = true },
    { location = "francecentral"
    enabled = true }
  ]
  enable_content_trust = true
  retention_policy = {
    days    = 10
    enabled = true
  }
  identity_ids = ["/subscriptions/xxxx-xxx-x-xx-xxxxx/resourceGroups/aksRGortheurope-aks_northeurope/providers/Microsoft.ManagedIdentity/userAssignedIdentities/northeurope-aks-agentpool"]
  tags = {
    "created By" = "Name",
    "Env"        = "DEV"
  }
}

```



## Requirements

| Terraform version | AzureRM Version |
| ----------------- | --------------- |
| 0.15.x & 1.0.x    | >= 2.10         |
| 0.13.x            | >= 2.10         | 

## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | 3.26.0    |

## Resource

| Name | Type |
|----- | ---- |
|azurerm_container_registry.acr | Resource |
|azurerm_resource_group.az_group | Resource |

## Inputs

| Name | Description | Type | Default | Required | 
| ---- | ----------- | ---- | ------- | -------- |
| create_acr_rg | Set the value `true` to create a new Resource Group| `bool` | NA | No |
| tags | Resource Tags | `map(string)` | NA | No | 
| location | Resource Location | `string` | NA | Yes |
| resource_group_name | Name of the Resource Group | `string` | NA |  Yes (only if the vaule of create_acr_rg is set `true` |
| create_acr_rg | Set the value true to create a new ACR | `bool` | NA | No |
| acr_resource_group | Name of ACR (name must be unique across Azure) | `string` |  NA | Yes |
| resource_group_name | Name of Resource Group   | `string` |  NA | Yes |
| acr_sku | The SKU of a container registry. | `string` | standard |  No|
|acr_admin_enabled | Enable Admin login | `bool` | false |NO|

## Outputs

| Name | Description |
|--|--|
|`container_registry_identity_principal_id`|The Principal ID for the Service Principal associated with the Managed Service Identity of this Container Registry
|`container_registry_identity_tenant_id`|The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry

### Additional Information

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

## Helpful links
[docs.microsoft.com/en-us/azure/container-registry/](https://docs.microsoft.com/en-us/azure/container-registry/)