module "s3_bucket_creation" {
    source               = "./"
    create_s3            = true
    name                 = "sample-bucket"
    tags                 = {"purpose" = "purpose of the bucket"}
    region               = "eu-west-2"
    log_bucket_name      = "log-bucket"
}



