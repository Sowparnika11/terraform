# Azure Log Analytics Workspace

![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

A Log Analytics workspace is a unique environment for log data from Azure Monitor and other Azure services, such as Microsoft Sentinel and Microsoft Defender for Cloud. Each workspace has its own data repository and configuration but might combine data from multiple services.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "log-analytics" {
  source              = "../modules/azure/log_analytics/code"
  name                = "log-analytics"
  location            = "northeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  tags = {
      "testTag" = "testValue"
  }
}
```
- With maximum parameters
```hcl
module "log-analytics" {
  source              =  "../modules/azure/log_analytics/code"
  name                = "log-analytics"
  location            = "northeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  solutions = [
      {
      name      = "AzureAutomation",
      publisher = "Microsoft",
      product   = "OMSGallery/AzureAutomation"
    }
  ]
  tags = {
      "testTag" = "testValue"
  }
}
```


## Requirements

| Name  | Version |
| ----- | ------- |
| <a name="requirement_azure"></a> [AZURE](#requirement\_azure) | >= 2.2 |
| <a name="requirement_terraform"></a> [Terraform](#requirement\_terraform) | >= 0.13 |


## Providers

| Name  | Version |
| ----- | ------- |
| <a name="provider_azurerm"></a> [Azure](#provider\_azurerm) | >= 3.38.0|


## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| log-analytics | ../modules/azure/log-analytics/code | 3.38.0|


# Resources 

| Name | Type |
|----- | ---- |
| azurerm_client_config | Data source |
| azurerm_resource_group | Data source |
| azurerm_resource_group | Resource |
| azurerm_log_analytics_workspace | Resource|
| azurerm_log_analytics_solution | Resource |

# Inputs

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| create_resource_group | Whether to create resource group and use it for all resources | `bool` | false | Yes |
| resource_group_name | The name of the resource group to deploy the log analytics workspace in to | `string` |NA | Yes|
| log_depends_on | A special variable used to pass in dependencies to the module | `any` | null | Yes |
| location | The location to deploy the log analytics workspace in to | `string` | NA | Yes|
| name | The name of the log analytics workspace | `string` | NA | Yes| 
| sku | Specifies which SKU to use. The sku for the log analytics workspace | `string` | PerGB2018 | Yes |
| retention_in_days | The retention period for data stored in the Log Analytics Workspace | `number` | 30 | Yes |
| solutions |  Solutions to install in to the log analytics workspace | `list(object({ name = string, publisher = string, product = string }))` | NA | No | 
| tags | Tags to apply to the log analytics workspace and solutions | `map(string)`| NA | No | 

# Outputs
| Name | Desription |
|--- | --- |
| id | Log Analytics Resource ID |
| workspace_id | Log Analytics Workspace Id |
| primary_shared_key | Log Analytics Workspace Primary Key |
| secondary_shared_key | Log Analytics Workspace Secondary Key |


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

