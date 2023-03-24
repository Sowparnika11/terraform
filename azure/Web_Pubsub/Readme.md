# Azure Web PubSub Service

![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

The Azure Web PubSub Service helps you build real-time messaging web applications using WebSockets and the publish-subscribe pattern easily. This real-time functionality allows publishing content updates between server and connected clients (for example a single page web application or mobile application). The clients do not need to poll the latest updates, or submit new HTTP requests for updates.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "pike" {
  source                 = "../modules/azure/pub_sub/code"
  name                   = "pike"
  location               = "northeurope"
  resource_group_name    = "poc-sf-terraform-training-ne-rg01"
  sku                    = "Standard_S1"
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
  }
}
```
- With maximum parameters
```hcl
module "pike" {
  source                 = "../modules/azure/pub_sub/code"
  name                   = "pike"
  location               = "northeurope"
  resource_group_name    = "poc-sf-terraform-training-ne-rg01"
  sku                    = "Standard_S1"
  aad_auth_enabled       = "true"
  local_auth_enabled     = "true"
  public_network_access_enabled = "false"
  enabled                   = "true"
  messaging_logs_enabled    = "true"
  connectivity_logs_enabled = "false"
  http_request_logs_enabled = "true"
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
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
| <a name="provider_azurerm"></a> [Azure](#provider\_azurerm) | >= 3.37.0|


## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| Web PubSub | ../modules/azure/event_hub/code | 3.37.0|


# Resources 

| Name | Type |
|----- | ---- |
| azurerm_client_config | Data source |
| azurerm_resource_group | Data source |
| azurerm_resource_group | Resource |
| azurerm_web_pubsub | Resource|
| azurerm_user_assigned_identity | Resource |
| azurerm_web_pubsub_hub | Resource |

# Inputs

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| name | Name of the PubSub | Yes|
| create_resource_group |Whether to create resource group and use it for all resources | `bool` | false | Yes |
| resource_group_name |The name of the resource group in which to create the Web PubSub service | `string` | NA | Yes|
| location | The name of the Web PubSub service | `string` | NA | Yes|
| sku | Specifies which SKU to use. Possible values are Free_F1 and Standard_S1 | `string` | Standard_S1 | Yes |
| capacity | Specifies the number of units associated with this Web PubSub resource.Valid values are: Free: 1, Standard: 1, 2, 5, 10, 20, 50, 100 | `number` | 1 | Yes |
| event_handler |  An event_handler block as defined below | `string` | NA | No | 
| url_template |  The Event Handler URL Template. Two predefined parameters {hub} and {event} are available to use in the template. The value of the EventHandler URL is dynamically calculated when the client request comes in | `string` | NA | Yes |
| user_event_pattern | Specify the matching event names | `string` | * | No | 


# Outputs
| Name | Desription |
|--- | --- |
| id | The ID of the Web PubSub service |


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

