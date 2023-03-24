variable "create_resource_group" {
  description = "Whether to create resource group and use it for all resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}

variable "app_plan_name" {
  type        = string
  description = "Name of app service plan to create"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created. By default in the same region as Resource Group"
  default     = null
}

variable "apps" {
  type        = any
  description = "Map of application and its settings"
}

variable "app_kind" {
  type        = string
  description = "Kind of app service plan"
  default     = "Windows"
}

variable "sku_tier" {
  type        = string
  description = "Specifies the plan's pricing tier"
  default     = "Free"
}

variable "sku_size" {
  type        = string
  description = "Specifies the plan's instance size"
  default     = "F1"
}

variable "sku_capacity" {
  type        = string
  description = "Specifies number of workers associated with this App Service Plan"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to resources"
  default     = {}
}

