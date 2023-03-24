# Azure Service Bus
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics (in a namespace). 
Service Bus is used to decouple applications and services from each other, providing the following benefits:
1.Load-balancing work across competing workers
2.Safely routing and transferring data and control across service and application boundaries
3.Coordinating transactional work that requires a high-degree of reliability
Features :
1.Message Sessions-With the help of message sessions, the Azure Service Bus can mix and handle unbounded sequences of linked messages.
2.Auto-Forwarding-With the use of auto-forwarding, you can divert messages from one Queue or Subscription to another within the same Namespace. It facilitates the scaling of individual Topics as well as the decoupling of message senders and receivers.
3.Detection of Duplicates-Bus can resend your message from the Queue or Topic to your recipient. The Duplicate Detection function is then activated, sending the message a second time while deleting any earlier copies you may have already sent.
4.Idle Auto-Delete-After a specific time, called the idle time interval, Microsoft Azure Service Bus automatically deletes your queue. Although you can customize your idle time period, the minimum time frame is five minutes.


## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "service_bus" { 
  location                = "northeurope"
  source                  = "../modules/azure/service_bus/code"
  resource_group_name     = "poc-sf-terraform-training-ne-rg01"
  sku                     = "Basic"
  capacity                = "0"
  topic_count             = "3"
  queue_count             = "3"
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
  }
}
```
- With maximum parameters
```hcl
module "service_bus" { 
  location                = "northeurope"
  source                  = "../modules/azure/service_bus/code"
  resource_group_name     = "poc-sf-terraform-training-ne-rg01"
  sku                     = "Basic"
  capacity                = "0"
  topic_count             = "3"
  queue_count             = "3"
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
| <a name="requirement_terraform"></a> [Terraform](#requirement\_terraform) | >= 3.43.0 |


## Providers

| Name  | Version |
| ----- | ------- |
| <a name="provider_azurerm"></a> [Azure](#provider\_azurerm) | >= 3.43.0 |


## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| servicebus | ../modules/azure/service_bus/code | 3.43.0 |


# Resources 

| Name | Type |
|----- | ---- |
| azurerm_client_config | Data source |
| azurerm_resource_group | Data source |
| azurerm_resource_group | Resource |
| azurerm_servicebus_namespace | Resource |
| azurerm_servicebus_namespace_authorization_rule | Resource |
| azurerm_servicebus_topic | Resource |
| azurerm_servicebus_topic_authorization_rule | Resource |
| azurerm_servicebus_subscription | Resource |
| azurerm_servicebus_subscription_rule | Resource |
| azurerm_servicebus_queue| Resource |
| azurerm_servicebus_queue_authorization_rule| Resource |

# Inputs

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| create_resource_group | Whether to create resource group and use it for all resources | `bool` | true | Yes |
| resource_group_name |  The name of the resource group in which to Changing this forces a new resource to be created. create the namespace | `string` | NA | Yes |
| location | Location of the resource group | `string` | NA | Yes |
| sku | The SKU of the namespace. The options are: `Basic`, `Standard`, `Premium` | `string` | Basic | Yes |
| capacity | The number of message units | `string` | 0 | Yes |
| tags | Map of tags to assign to the resources | `list(string)` | {} | No |
| topic_count | Number of topics to be created | `number` | 1 | Yes |
| queue_count | Number of queues to be created | `number` | 1 | Yes |
| auto_delete_on_idle| he ISO 8601 timespan duration of the idle interval after which the Queue is automatically deleted| `number`| PT5M| Yes |
| default_message_ttl | The ISO 8601 timespan duration of the TTL of messages sent to this queue | `number`| NA | yes |
| enable_batched_operations|Boolean flag which controls whether server-side batched operations are enabled| `boolean`| true | Yes |
| enable_partitioning |Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers. Changing this forces a new resource to be created| `boolean`| false | Yes |
| enable_duplicate_detection| the ISO 8601 timespan duration during which duplicates can be detected| `number`|10| No |
| enable_express|Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage| `boolean`| false | No |
| lock_duration|The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers| `string`| PT1M | No |
| max_delivery_count| Integer value which controls when a message is automatically dead lettered| `number`|10| No |
| forward_to|The name of a Queue or Topic to automatically forward messages to| `string`| NA | No |
| enable_session|Boolean flag which controls whether the Queue requires sessions| `boolean`| false | No |
| duplicate_detection_history_time_window|Apart from just enabling duplicate detection, you can also configure the size of the duplicate detection history time window during which message-ids are retained| `string` | true 
| enable_dead_lettering_on_message_expiration|To enable the dead lettering on message expiration setting for a subscription to a topic|`string`| PT10M | No


# Outputs
| Name | Desription |
|--- | --- |

| id | Namespace_id | The ServiceBus Namespace ID |
| servicebus_namespace_name | ServiceBus Namespace Name |

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

