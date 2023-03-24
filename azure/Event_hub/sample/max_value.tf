module "simple" {
  source              = "../modules/azure/event_hubs/code"
  name                = "simple"
  location            = "westeurope"
  resource_group_name = "poc-sf-terraform-training-ne-rg01"
  sku                 = "Standard"
  capacity            = 1
  hubs = [
    {
      name              = "input"
      partitions        = 8
      message_retention = 1
      consumers = [
        "app1",
        "app2"
      ]
      keys = [
        {
          name   = "app1"
          listen = true
          send   = false
        },
        {
          name   = "app2"
          listen = true
          send   = true
        }
      ]
    }
  ]
}
