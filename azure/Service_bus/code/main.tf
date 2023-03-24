data "azurerm_client_config" "config" {}
locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.datarg.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.datarg.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}

data "azurerm_resource_group" "datarg" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
}

resource "azurerm_servicebus_namespace" "main" {
  name                = "ServiceBus-Namespaces"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = var.sku
  capacity            = var.capacity
  tags                = var.tags
}

resource "azurerm_servicebus_namespace_authorization_rule" "main" {
  name         = "servicebus-rules"
  namespace_id = azurerm_servicebus_namespace.main.id

  listen = true
  send   = true
  manage = false
}

resource "azurerm_servicebus_topic" "main" {
  count        = var.topic_count
  name         = "servicebus_topics_${count.index}"
  namespace_id = azurerm_servicebus_namespace.main.id
  enable_partitioning = true
}

resource "azurerm_servicebus_topic_authorization_rule" "main" {
  count    = var.topic_count
  name     = "servicebus_topic_rules_${count.index}"
  topic_id = azurerm_servicebus_topic.main[count.index].id 
  listen   = true
  send     = false
  manage   = false
}

resource "azurerm_servicebus_subscription" "main" {
  count              = var.topic_count
  name               = "servicebus_subscription_${count.index}"
  topic_id           = azurerm_servicebus_topic.main[count.index].id 
  max_delivery_count = 1
}

resource "azurerm_servicebus_subscription_rule" "main" {
  count           = var.topic_count
  name            = "servicebus_subcription_rule_${count.index}"
  subscription_id = azurerm_servicebus_subscription.main[count.index].id 
  filter_type     = "SqlFilter"
  sql_filter      = "colour = 'red'"
}

resource "azurerm_servicebus_queue" "main" {
  count        = var.queue_count
  name         = "servicebus_queue_${count.index}"
  namespace_id = azurerm_servicebus_namespace.main.id

  enable_partitioning = true
}

resource "azurerm_servicebus_queue_authorization_rule" "main" {
  count    = var.queue_count
  name     = "queue_rule"
  queue_id = azurerm_servicebus_queue.main[count.index].id 

  listen = true
  send   = true
  manage = false
}