# Azure Notification Hub

![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Azure Notification Hubs provide an easy-to-use and scaled-out push engine that enables you to send notifications to any platform (iOS, Android, Windows, etc.) from any back-end (cloud or on-premises). Notification Hubs works great for both enterprise and consumer scenarios.


## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "notificationhub" {

source                          = "../modules/azure/notification_hub/code"
location                        = "northeurope"
resource_group_name             = "poc-sf-terraform-training-ne-rg01"
notification_hub_namespace_name = "myhubnamespace"
notification_hub_name           = "myhubname"
namespace_type                  = "NotificationHub"
sku_name                        = "Free"
 
}
```
- With maximum parameters
```hcl
module "notificationhub" {

source                          = "../modules/azure/notification_hub/code"
location                        = "northeurope"
resource_group_name             = "poc-sf-terraform-training-ne-rg01"
notification_hub_namespace_name = "myhubnamespace"
notification_hub_name           = "myhubname"
namespace_type                  = "NotificationHub"
sku_name                        = "Free"
 
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
| <a name="provider_azurerm"></a> [Azure](#provider\_azurerm) | >= 3.41.0|


## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| notificationhub | ../modules/azure/notification_hub/code | 3.41.0|


# Resources 

| Name | Type |
|----- | ---- |
| azurerm_client_config | Data source |
| azurerm_resource_group | Data source |
| azurerm_resource_group | Resource |
| azurerm_notification_hub_namespace | Resource|
| azurerm_notification_hub | Resource |
| azurerm_notification_hub_authorization_rule | Resource |

# Inputs

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| create_resource_group | Whether to create resource group and use it for all resources | `bool` | false | Yes |
| resource_group_name | Name of the resource group in which the Notification Hub should be created | `string` |  NA | Yes|
| notification_hub_namespace_name | Name of the Notification Hub Namespace | `string` | NA | Yes|
| notification_hub_name | Name of the Notification Hub | `string` | NA | Yes |
| location | The Azure Region in which this Notification Hub Namespace should be created | `string` | NA | Yes |
| namespace_type | The Type of Namespace | `string` | NA | Yes | 
| sku_name | The name of the SKU to use for this Notification Hub Namespace | `string` | Free | Yes |



# Outputs
| Name | Desription |
|--- | --- |
| id | The ID of the notification hub namespace |


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

