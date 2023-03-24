# Azure EventHub

![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Azure Event Hubs is a big data streaming platform and event ingestion service. It can receive and process millions of events per second. Data sent to an event hub can be transformed and stored by using any real-time analytics provider or batching/storage adapters. 
Azure Event Hubs are designed for scale, it can process millions and millions of messages on both directions – inbound and outbound. Some of the real-world use cases include getting telemetry data from cars, games, application, IoT scenarios where millions of devices push data to the cloud, gaming scenarios where you push user activities at scale to the cloud, etc. 

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "simple" {
  source              = "../modules/azure/event_hubs/code"
  name                = "simple"
  location            = "westeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  sku                 = "Standard"
  capacity            = 1
}
```
- With maximum parameters
```hcl
module "simple" {
  source              = "../modules/azure/event_hubs/code"
  name                = "simple"
  location            = "westeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  sku                 = "Standard"
  capacity            = 1
  hubs = [
    {
      name              = "input"
      partitions        = 8
      message_retention = 1
      consumers = [
        "app1",
        "app2"
      ]
      keys = [
        {
          name   = "app1"
          listen = true
          send   = false
        },
        {
          name   = "app2"
          listen = true
          send   = true
        }
      ]
    }
  ]
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
| <a name="provider_azurerm"></a> [Azure](#provider\_azurerm) | >= 3.34.0|


## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| EventHub | ../modules/azure/event_hub/code | 3.34.0|


# Resources 

| Name | Type |
|----- | ---- |
| azurerm_resource_group | Data source |
| azurerm_eventhub_namespace | Resource |
| azurerm_eventhub_namespace_authorization_rule| Resource |
| azurerm_eventhub| Resource|
| azurerm_eventhub_consumer_group | Resource|
| azurerm_eventhub_authorization_rule | Resource|
| azurerm_monitor_diagnostic_categories| Data source |

# Inputs

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| name | Name of the eventhub | Yes|
| create_resource_group | reate resource group and use it for all resources| `bool` | false
| resource_group_name | Name of the existing resource group | `string` | NA | Yes|
| location | Azure location where resources should be deployed | `string` | NA | Yes|
| sku | Defines which tier to use.The options are: `Basic`, `Standard`, `Premium` | `string` | Basic | Yes |
| capacity | The number of message units | `number` | 1 | Yes |
| authorization_rules | `list` |[] | Yes |
| hubs | A list of event hubs to add to namespace |`list`| [] | No |
| tags | Tags to apply to all resources created | `map(string)`| NA | No | 
| auto_inflate | Auto Inflate enabled for the EventHub Namespace | `list` | NA | No |
| diagnostics | Diagnostic settings for those resources that support it | `list` | Null | No |
| network_rules | Network rules restricting access to the event hub | `list` | NA | Yes |






| auto_delete_on_idle| he ISO 8601 timespan duration of the idle interval after which the Queue is automatically deleted| `number`| PT5M| Yes |
| default_message_ttl | The ISO 8601 timespan duration of the TTL of messages sent to this queue | `number`| NA | yes |
| enable_batched_operations|Boolean flag which controls whether server-side batched operations are enabled| `boolean`| true | Yes |
| enable_partitioning |Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers. Changing this forces a new resource to be created| `boolean`|false| Yes |
| enable_duplicate_detection| the ISO 8601 timespan duration during which duplicates can be detected| `number`|10| No |
| enable_express|Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage| `boolean`| false | No |
| lock_duration|The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers| `string`| PT1M | No |
| max_delivery_count| Integer value which controls when a message is automatically dead lettered| `number`|10| No |
| forward_to|The name of a Queue or Topic to automatically forward messages to| `string`| NA | No |
| enable_session|Boolean flag which controls whether the Queue requires sessions| `boolean`| false | No |
| duplicate_detection_history_time_window|Apart from just enabling duplicate detection, you can also configure the size of the duplicate detection history time window during which message-ids are retained| 'string' |true
| enable_dead_lettering_on_message_expiration|To enable the dead lettering on message expiration setting for a subscription to a topic|'string'| PT10M


# Outputs
| Name | Desription |
|--- | --- |
| namespace_id | Id of Event Hub Namespace |
| hub_ids | Map of hubs and their ids |
| keys | Map of hubs with keys => primary_key / secondary_key mapping |
| authorization_keys | "Map of authorization keys with their ids |

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

