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

resource "azurerm_notification_hub_namespace" "main" {
  name                = "myappnamespace"
  location            = local.location
  resource_group_name = local.resource_group_name
  namespace_type      = var.namespace_type

  sku_name            = var.sku_name
}

resource "azurerm_notification_hub" "main" {
  name                = "mynotificationhub"
  namespace_name      = azurerm_notification_hub_namespace.main.name
  resource_group_name = local.resource_group_name
  location            = local.location
}

resource "azurerm_notification_hub_authorization_rule" "main" {
  name                  = "AuthorizationRule"
  notification_hub_name = azurerm_notification_hub.main.name
  namespace_name        = azurerm_notification_hub_namespace.main.name
  resource_group_name   = local.resource_group_name
  manage                = true
  send                  = true
  listen                = true
}

