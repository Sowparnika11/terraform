module "create_container_registry" {
  source                = "../azure_acr/code/"
  resource_group_name   = "hs"
  acr_name = "acr0011w"
  
}

