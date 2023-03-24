output "apps" {
  description = "Map of deployed web applications"
  value = {
    for a in azurerm_windows_web_app.main :
    a.name => {
      id                             = a.id
      name                           = a.name
      outbound_ip_addresses          = a.outbound_ip_addresses
      possible_outbound_ip_addresses = a.possible_outbound_ip_addresses
      identity                       = a.identity
    }
  }
}

output "site_credentials" {
  description = "Map of site credentials for applications"
  sensitive   = true
  value = {
    for a in azurerm_windows_web_app.main :
    a.id => {
      id              = a.id
      site_credential = a.site_credential
    }
  }
}