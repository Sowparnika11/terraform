variable "create_resource_group" {
  description = "Whether to create resource group and use it for all resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to Changing this forces a new resource to be created. create the namespace."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists" 
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "Defines which tier to use. Options are Basic, Standard or Premium"
}

variable "capacity" {
  type        = number
  default     = 0
  description = "Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4, 8 or 16. When sku is Basic or Standard, capacity can be 0 only."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to assign to the resources."
}

variable "queue_count" {
  type        = number
  default     = 1 
  description = "Number of queues to be created"
}

variable "topic_count" {
  type        = number
  default     = 1
  description = "Number of topics to be created"
}
