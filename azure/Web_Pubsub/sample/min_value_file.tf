module "pike" {
  source                 = "../modules/azure/pub_sub/code"
  name                   = "pike"
  location               = "northeurope"
  resource_group_name    = "poc-sf-terraform-training-ne-rg01"
  sku                    = "Standard_S1"
  url_template           = "https://management.azure.com/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.SignalRService/webPubSub/myWebPubSubService/hubs?api-version=2022-08-01-preview"
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
  }
}