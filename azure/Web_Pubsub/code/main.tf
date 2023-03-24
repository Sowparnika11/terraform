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

resource "azurerm_web_pubsub" "main" {
  name                = "webbpubsub"
  location            = local.location
  resource_group_name = local.resource_group_name

  sku      = var.sku
  capacity = var.capacity

  public_network_access_enabled = false

  live_trace {
    enabled                   = true
    messaging_logs_enabled    = true
    connectivity_logs_enabled = false
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_user_assigned_identity" "main" {
  name                = "uai-iden"
  resource_group_name = azurerm_web_pubsub.main.name
  location            = azurerm_web_pubsub.main.location
}

resource "azurerm_web_pubsub_hub" "main" {
  name          = "wpsh"
  web_pubsub_id = azurerm_web_pubsub.main.id
  event_handler {
    url_template       = var.url_template
    user_event_pattern = "*"
    system_events      = ["connect", "connected"]
  }

  event_handler {
    url_template       = var.url_template
    user_event_pattern = "event1, event2"
    system_events      = ["connected"]
    auth {
      managed_identity_id = azurerm_user_assigned_identity.main.id
    }
  }
  anonymous_connections_enabled = true

  depends_on = [
    azurerm_web_pubsub.main
  ]
}
