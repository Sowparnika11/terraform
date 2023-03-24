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


resource "azurerm_service_plan" "main" {
  name                = var.app_plan_name
  location            = local.location
  resource_group_name = local.resource_group_name
  os_type             = "Windows"
  sku_name            = "F1"  
}

resource "azurerm_windows_web_app" "main" {
  for_each            = var.apps
  name                = lookup(each.value, "name")
  location            = local.location
  resource_group_name = local.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id
  tags                = "${merge(var.tags, lookup(each.value, "tags", {}))}"
  app_settings        = lookup(each.value, "app_settings", {})

  site_config {

    always_on                 = lookup(each.value, "always_on", "false")
    websockets_enabled        = lookup(each.value, "websockets_enabled", "false")
    default_documents         = lookup(each.value, "default_documents", [])
  }

  lifecycle {
  ignore_changes = []
  }

}