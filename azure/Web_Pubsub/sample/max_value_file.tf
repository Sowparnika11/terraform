module "pike" {
  source                 = "../modules/azure/pub_sub/code"
  name                   = "pike"
  location               = "northeurope"
  resource_group_name    = "poc-sf-terraform-training-ne-rg01"
  sku                    = "Standard_S1"
  url_template           = "https://management.azure.com/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.SignalRService/webPubSub/myWebPubSubService/hubs?api-version=2022-08-01-preview"
  aad_auth_enabled       = "true"
  local_auth_enabled     = "true"
  public_network_access_enabled = "false"
  enabled                   = "true"
  messaging_logs_enabled    = "true"
  connectivity_logs_enabled = "false"
  http_request_logs_enabled = "true"
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
  }
}