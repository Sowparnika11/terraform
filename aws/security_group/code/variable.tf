variable "name" {
  type        = string
  description = "Name of the security group"
  default     = "sample_sg"
}
variable "location" {
    type = string
    description = "location"
}
variable "create_sg"{
    type  = bool
    description  = "To decide whether to create a new security group or not"
    default = true
}

variable "description" {
    type = string
    description = "Security group description"
    default   = "Description for the security group"
}

variable "vpc_id" {
    type = string
    description = "Id of vpc.Defaults to the region's default VPC"
}
variable "ingress_description" {
    type  = string
    description = "Description of this ingress rule"
    default   = "ingress description"
}
variable "ingress_from" {
    type  = number
    description = "Ingress start port"
    default   = 443
}
variable "ingress_to" {
    type  = number
    description = "Ingress end port"
    default   = 443
}
variable "ingress_protocol" {
    type  = string
    description = "The protocol used for ingress."
    default   = "tcp"
}
variable "vpc_cidr" {
    type  = list(string)
    description = "List of ingress rules to create where 'cidr_blocks' is used"
    default   = []
}
variable "ipv6_cidr" {
    type  = list(string)
    description = "List of ingress rules to create where 'ipv6_cidr_blocks' is used"
    default   = []
}

variable "egress_from" {
    type  = number
    description = "Egress from port"
    default   = 0
}
variable "egress_to" {
    type  = number
    description = "egress to port"
    default   = 0
}
variable "egress_protocol" {
    type  = string
    description = "egress protocol"
    default   = "-1"
}
variable "egress_cidr" {
    type  = list(string)
    description = "List of egress rules to create where 'cidr_blocks' is used"
    default   = ["0.0.0.0/0"]
}
variable "egress_ipv6_cidr" {
    type  = list(string)
    description = "List of IPv6 CIDR blocks"
    default   = ["::/0"]
}
variable "tags"{
    type = map(any)
    description = "tags for s3 bucket"
    default = {}
}