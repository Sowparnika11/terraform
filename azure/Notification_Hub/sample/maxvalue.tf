module "notificationhub" {

source                          = "../modules/azure/notification_hub/code"
location                        = "northeurope"
resource_group_name             = "poc-sf-terraform-training-ne-rg01"
notification_hub_namespace_name = "myhubnamespace"
notification_hub_name           = "myhubname"
namespace_type                  = "NotificationHub"
sku_name                        = "Free"
 
}