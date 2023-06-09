output "container_registry_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "container_registry_login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = azurerm_container_registry.acr.login_server
}

output "container_registry_identity_principal_id" {
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this Container Registry"
  value       = flatten(azurerm_container_registry.acr.identity.*.principal_id)
}

output "container_registry_identity_tenant_id" {
  description = "The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry"
  value       = flatten(azurerm_container_registry.acr.identity.*.tenant_id)
}
