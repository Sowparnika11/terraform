module "create_container_registry" {
  source                = "../azure_acr/code/"
  create_resource_group = true
  resource_group_name   = "acr"
  location              = "Northeurope"
  acr_name                      = "acr0011w"
  acr_sku                       = "Premium"
  public_network_access_enabled = false
  quarantine_policy_enabled     = false
  zone_redundancy_enabled       = true
  georeplications = [
    { location = "uksouth"
    enabled = true },
    { location = "francecentral"
    enabled = true }
  ]
  enable_content_trust = true
  retention_policy = {
    days    = 10
    enabled = true
  }
  identity_ids = ["/subscriptions/xxxx-xxx-x-xx-xxxxx/resourceGroups/aksRGortheurope-aks_northeurope/providers/Microsoft.ManagedIdentity/userAssignedIdentities/northeurope-aks-agentpool"]
  tags = {
    "created By" = "Name",
    "Env"        = "DEV"
  }
}

