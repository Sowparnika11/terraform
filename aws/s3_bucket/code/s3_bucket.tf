resource "aws_s3_bucket" "s3_bucket"{
  count = var.create_s3 ? 1 : 0
  bucket = var.name
  tags = merge(
    var.tags,
    {
    Name = "${var.name}"
  },
  )
}
resource "aws_s3_bucket_acl" "sample_bucket_acl" {
  count  = var.create_s3 ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket[0].id
  acl    = var.acl_value
}

resource "aws_s3_bucket_versioning" "versioning_sample" {
  count  = var.create_s3 ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket[0].id
  versioning_configuration {
    status = var.versioning_status
  }
}
############# public access block ############################################
resource "aws_s3_bucket_public_access_block" "public_access" {
  count  = var.create_s3 ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket[0].id

  block_public_acls   = var.block_public_acls  
  block_public_policy = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  ignore_public_acls      = var.ignore_public_acls
}
###### server side encryption ###############################################
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  count         = var.create_s3 ? 1: 0
  bucket        = aws_s3_bucket.s3_bucket[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      # kms_master_key_id = aws_kms_key.sample_key[0].arn
      sse_algorithm     = var.s3_sse_algorithm # The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms
    }
  }
}

############ logging #########################################################
resource "aws_s3_bucket" "log_bucket" {
  count         = var.create_s3 && var.create_log ? 1: 0
  bucket        = var.log_bucket_name
}
resource "aws_s3_bucket_public_access_block" "log_access" {
  count         = var.create_s3 && var.create_log ? 1: 0
  bucket        = aws_s3_bucket.log_bucket[0].id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_versioning" "log_versioning"{
  count  = var.create_s3 && var.create_log ? 1 : 0
  bucket = aws_s3_bucket.log_bucket[0].id
  versioning_configuration {
    status = var.log_versioning_status
  }
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  count  = var.create_s3 && var.create_log ? 1 : 0
  bucket = aws_s3_bucket.log_bucket[0].id
  acl    = var.log_acl_value
}
resource "aws_s3_bucket_logging" "example" {
  count         = var.create_s3 ? 1: 0
  bucket        = aws_s3_bucket.s3_bucket[0].id

  target_bucket = var.create_log ? aws_s3_bucket.log_bucket[0].id : var.target_bucket_id
  target_prefix = var.log_prefix
}

###### server side encryption for log bucket ###############################################
resource "aws_s3_bucket_server_side_encryption_configuration" "log_encryption" {
  count  = var.create_s3 && var.create_log ? 1 : 0
  bucket = aws_s3_bucket.log_bucket[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      # kms_master_key_id = aws_kms_key.log_key[0].arn
      sse_algorithm     = var.log_sse_algorithm #The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms
    }
  }
}
resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  count             = var.create ? 1 : 0
  name              = "/aws/s3/${var.name}"
  retention_in_days = var.retention_in_days
  tags = {
    name    = "${var.name}-s3-cloudwatch"
  }
}

