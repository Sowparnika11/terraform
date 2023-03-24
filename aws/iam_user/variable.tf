variable "user_name" {
    type        = string
    description = "(Required) Name of the iam user"
}
variable "tags" {
    type = map(any)
    default = null
}
variable "region" {
    type = string
    description = "location"
}