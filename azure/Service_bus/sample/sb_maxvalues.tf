module "service_bus" { 
  location                = "northeurope"
  source                  = "../modules/azure/service_bus/code"
  resource_group_name     = "poc-sf-terraform-training-ne-rg01"
  sku                     = "Basic"
  capacity                = "0"
  topic_count             = "3"
  queue_count             = "3"
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
  }
}
