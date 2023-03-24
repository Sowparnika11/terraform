variable "create_resource_group" {
  description = "Whether to create resource group and use it for all resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Web PubSub service"
}

variable "url_template" {
  type = any
  description = "The Event Handler URL Template"
  
}

variable "location" {
  type         = string
  description  = "Specifies the supported Azure location where the Web PubSub service exists"
}

variable "sku" {
  type        = string
  description = "Specifies which SKU to use. Possible values are Free_F1 and Standard_S1"
  default     = "Standard_S1"
}

variable "capacity" {
  type        = number
  description = "Specifies the number of units associated with this Web PubSub resource.Valid values are: Free: 1, Standard: 1, 2, 5, 10, 20, 50, 100"
  default     = 1
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(any)
}
