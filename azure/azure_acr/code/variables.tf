variable "create_resource_group" {
  description = "Whether to create resource group and use it for all resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to use. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
    default     = ""
}

variable "acr_name" {
  default     = null
  type        = string
  description = "Name of the Azure Continer Registry"
}

variable "acr_sku" {
  description = "The SKU name of the container registry"
  default     = "Premium"
  type        = string
}

variable "acr_admin_enabled" {
  description = "Enable Admin login"
  default     = "false"

}


variable "quarantine_policy_enabled" {
  description = "Enable quarantine policy"
  default     = "false"

}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundancy"
  default     = "false"

} 

variable "public_network_access_enabled" {
  description = "Enable Public Network Access."
  default     = "false"

}

variable "tags" {
  description = "The tags attached to the resource"
  type        = map(string)
  default     = {}
}

variable "georeplications" {
  description = "A list of Azure locations where the container registry should be geo-replicated"
  type = list(object({
    location                = string
    enabled = bool
  }))
  default = []
}

variable "retention_policy" {
  description = "Set a retention policy for untagged manifests"
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = null
}

variable "enable_content_trust" {
  description = "Boolean value to enable or disable Content trust in Azure Container Registry"
  default     = false
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`"
  default     = null
}