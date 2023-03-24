module "log-analytics" {
  source              =  "../modules/azure/log_analytics/code"
  name                = "log-analytics"
  location            = "northeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  solutions = [
      {
      name      = "AzureAutomation",
      publisher = "Microsoft",
      product   = "OMSGallery/AzureAutomation"
    }
  ]
  tags = {
      "testTag" = "testValue"
  }
}