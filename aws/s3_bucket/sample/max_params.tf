module "s3_bucket_creation" {
    source                       = "./code"
    create_s3                    = true
    name                         = "sample-bucket"
    tags                         = {"purpose" = "purpose of the bucket"}
    region                       = "eu-west-2"
    acl_value                    = "private"
    log_bucket_name              = "log-bucket"
    versioning_status            = "Enabled"
    block_public_acls            = true
    block_public_policy          = true
    restrict_public_buckets      = true
    ignore_public_acls           = true
    kms_description              = "This key is used to encrypt bucket objects"
    deletion_window_in_days      = 7
    enable_key_rotation          = true
    log_versioning_status        = "Enabled"
    log_acl_value                = "log-delivery-write"
    log_prefix                   = "log/"
    log_kms_alias                = "log-bucket-key-alias"
    log_sse_algorithm            = "aws:kms" #AES256
    create                       = false
    retention_in_days            = 7
}








