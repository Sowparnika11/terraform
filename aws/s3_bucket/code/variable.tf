variable "name" {
    type        = string
    description = "(Required) Name of the S3 Bucket"
}
variable "create_s3" {
    type        = bool
    description = "to decide whether s3 is to be created or not "
    default     = true
}
variable "create_log"{
    type        = bool
    description = "to decide whether s3 log bucket is to be created or not "
    default     = true

}
variable "target_bucket_id"{
    type       = string
    description = "Customized target bucket ID for logging"
    default     = ""
}
variable "tags" {
    type = map(any)
    description = "tags for s3 bucket"
    default = {}
}
variable "region" {
    type = string
    description = "location"
}
variable "acl_value" {
    type = string
    description = "The canned ACL to apply to the bucket"
    default = "private"
}
variable "versioning_status" {
    type = string
    description = "to decide whether versioning should be enabled or not"
    default = "Enabled"
}
variable "log_bucket_name"{
    type = string 
    default = "log-bucket"
}
variable "log_versioning_status" {
    type = string
    description = "to decide whether versioning should be enabled or not"
    default = "Enabled"
}
variable "log_acl_value" {
    type = string
    default = "log-delivery-write"
}
variable "log_prefix" {
    type= string
    default = "log/"
    description = "prifix value for the log s3 bucket"
}
variable "log_kms_alias"{
    type = string   
    default = "log-bucket-key-alias"
    description = "alsie name for log s3 bucket kms key"

}
variable "s3_kms_alias"{
    type = string   
    default = "s3-bucket-key-alias"
    description = "alsie name for s3 bucket kms key"
}

variable "s3_sse_algorithm" {
    type = string
    default = "aws:kms"
    description = "sse algorith for s3 bucket server side encryption"
}

variable "log_sse_algorithm" {
    type = string
    default = "aws:kms"
    description = "sse algorith for log s3 bucket server side encryption"
}
variable "block_public_acls"{
    type = bool
    description = "Whether Amazon S3 should block public ACLs for this bucket"
    default = true
}
variable "block_public_policy"{
    type = bool
    description = "Whether Amazon S3 should block public bucket policies for this bucket"
    default = true
}
variable "restrict_public_buckets"{
    type = bool
    description = "Whether Amazon S3 should block public ACLs for this bucket"
    default = true
}
variable "ignore_public_acls"{
    type = bool
    description = "Whether Amazon S3 should ignore public ACLs for this bucket"
    default = true
}
variable "kms_description" {
    type = string
    description = "This key is used to encrypt bucket objects"
    default = ""
}
variable "deletion_window_in_days" {
    type =  number
    description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key"
    default = 7
}
variable "enable_key_rotation"{
    type = bool
    description = "Specifies whether key rotation is enabled"
    default = true
}
variable "create" {
    type = bool
    description = "to decide whether S3 bucket cloud watch log needs to be created or not"
    default = false
}
variable "retention_in_days" {
  type = number
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire"
  default     = 7
}