variable "create_resource_group" {
  description = "Whether to create resource group and use it for all resources"
  type        = bool
  default     = false 
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group in which the Notification Hub should be created"
}

variable "location" {
  description = "The Azure Region in which this Notification Hub Namespace should be created"
  type        = string 
}

variable "namespace_type" {
  description = "The Type of Namespace" 
  type        = string
}

variable "sku_name" {
  description = "The name of the SKU to use for this Notification Hub Namespace"
  default     = "Free"
  type        = string
}
