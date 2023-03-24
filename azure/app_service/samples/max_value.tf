module "app-service" {
  source                 = "../modules/azure/app_service/code"
  location               = "northeurope"
  resource_group_name    = "poc-sf-terraform-training-ne-rg01"
  sku_capacity           = "F1"
  sku_tier               = "Free"
  apps = {
  api = {
    name      = "project-api"
    always_on = true
    app_settings = {
      "WEBSITE_NODE_DEFAULT_VERSION" = "8.11.1"
    }
    use_32_bit_worker_process = false
  },
  web = {
    name = "project-web"
    tags = {}
    app_settings = {
      "WEBSITE_NODE_DEFAULT_VERSION" = "8.11.1"
    }
    default_documents = [
      "Default.htm",
      "Default.html",
      "Default.asp",
      "index.htm",
      "index.html",
      "iisstart.htm",
      "default.aspx",
      "index.php",
      "hostingstart.html",
    ]
  }
}
  app_kind               = "Windows"
  app_plan_name          = "AppServ" 
  tags = {
    "env"  = "Non-Prod"
    "Name" = "azm"
  }
}