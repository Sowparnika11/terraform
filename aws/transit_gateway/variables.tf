variable "create_transit_gateway" {
  type        = bool
  default     = true
  description = "Whether to create a Transit Gateway. If set to `false`, an existing Transit Gateway ID must be provided in the variable `existing_transit_gateway_id`"
}

variable "transit_gateway_cidr_blocks" {
  type        = list(string)
  default     = null
  description = "The list of associated CIDR blocks. It can contain up to 1 IPv4 CIDR block  of size up to /24 and up to one IPv6 CIDR block of size up to /64. The IPv4  block must not be from range 169.254.0.0/16."
  }

variable "transit_gateway_description" {
  type        = string
  default     = ""
  description = "Transit Gateway description. If not provided, one will be automatically generated."
}

variable "auto_accept_shared_attachments" {
  type        = string
  default     = "enable"
  description = "Whether resource attachment requests are automatically accepted. Valid values: `disable`, `enable`. Default value: `disable`"
}  

variable "default_route_table_association" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments are automatically associated with the default association route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "default_route_table_propagation" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}
variable "dns_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}
variable "vpn_ecmp_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}
variable "tags" {
  type    = map(any)
  default = null
}

variable "location" {
  default = null
}
