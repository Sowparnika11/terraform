output "servicebus_namespace_name" {
  value       = azurerm_servicebus_namespace.main.name
  description = "ServiceBus Namespace Name"
}

output "id" {
  value       = azurerm_servicebus_namespace.main.id 
  description = "The ServiceBus Namespace ID"
}
