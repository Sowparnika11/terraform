# Azure App Service 

![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. You can develop in your favorite language, be it .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python. Applications run and scale with ease on both Windows and Linux-based environments.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "app-service" {
  source                 = "../modules/azure/app_service/code"
  location               = "northeurope"
  resource_group_name    = "poc-sf-terraform-training-ne-rg01"
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
```
- With maximum parameters
```hcl
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
```


## Requirements

| Name  | Version |
| ----- | ------- |
| <a name="requirement_azure"></a> [AZURE](#requirement\_azure) | >= 2.2 |
| <a name="requirement_terraform"></a> [Terraform](#requirement\_terraform) | >= 0.13 |


## Providers

| Name  | Version |
| ----- | ------- |
| <a name="provider_azurerm"></a> [Azure](#provider\_azurerm) | >= 3.39.1|


## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| app-service | ../modules/azure/app_service/code | 3.39.1|


# Resources 

| Name | Type |
|----- | ---- |
| azurerm_client_config | Data source |
| azurerm_resource_group | Data source |
| azurerm_resource_group | Resource |
| azurerm_service_plan | Resource|
| azurerm_windows_web_app | Resource |

# Inputs

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| create_resource_group | Whether to create resource group and use it for all resources | `bool` | false | Yes |
| resource_group_name | The name of the resource group | `string` |NA | Yes|
| app_plan_name | A special variable used to pass in dependencies to the module | `string` | null | Yes |
| location | Azure region where resources will be created | `string` | null | Yes|
| apps | Map of application and its settings | `any` | NA | Yes| 
| app_kind | Kind of app service plan | `string` | Windows | Yes |
| sku_tier | Specifies the plan's pricing tier | `string` | Free | Yes |
| sku_size | Specifies the plan's instance size | `string` | F1 | Yes | 
| sku_capacity | Specifies number of workers associated with this App Service Plan | `string` | null | Yes | 
| tags | Map of tags to assign resources | `map(string)`| {} | No | 

# Outputs
| Name | Desription |
|--- | --- |
| apps | Map of deployed web applications |
| site_credentials | Map of site credentials for applications |


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

