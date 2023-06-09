variable "create_resource_group" {
  description = "Whether to create resource group and use it for all resources"
  type        = bool
  default     = false
}

variable "log_depends_on" {
    type = any
    description = "A special variable used to pass in dependencies to the module"
    default = null
}

variable "resource_group_name" {
    type = string
    description = "The name of the resource group to deploy the log analytics workspace in to."
}

variable "location" {
    type = string
    description = "The location to deploy the log analytics workspace in to."
}

variable "name" {
    type = string
    description = "The name of the log analytics workspace"
}

variable "sku" {
    type = string
    description = "The sku for the log analytics workspace."
    default = "PerGB2018"
}

variable "retention_in_days" {
    type = number
    description = "The retention period for data stored in the Log Analytics Workspace"
    default = 30
}

variable "solutions" {
    type = list(object({ name = string, publisher = string, product = string }))
    description = "Solutions to install in to the log analytics workspace."
    default = []
}

variable "tags" {
    type = map(string)
    description = "Tags to apply to the log analytics workspace and solutions."
    default = {}
}