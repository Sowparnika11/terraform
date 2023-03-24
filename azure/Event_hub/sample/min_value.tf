module "simple" {
  source              = "../modules/azure/event_hubs/code"
  name                = "simple"
  location            = "westeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  sku                 = "Standard"
  capacity            = 1
}