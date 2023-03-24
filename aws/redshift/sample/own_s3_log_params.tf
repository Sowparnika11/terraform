module "s3_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = "example-rc-logging"
  acl    = "log-delivery-write"

  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_redshift.json

  attach_deny_insecure_transport_policy = true
  force_destroy                         = true
  block_public_acls                     = true
  block_public_policy                   = true
  ignore_public_acls                    = true
  restrict_public_buckets               = true

  tags = {
    terraform = true
  }
}

data "aws_redshift_service_account" "this" {}

data "aws_iam_policy_document" "s3_redshift" {

  statement {
    sid       = "RedshiftAcl"
    actions   = ["s3:GetBucketAcl"]
    resources = [module.s3_logs.s3_bucket_arn]

    principals {
      type        = "AWS"
      identifiers = [data.aws_redshift_service_account.this.arn]
    }
  }

  statement {
    sid       = "RedshiftWrite"
    actions   = ["s3:PutObject"]
    resources = ["${module.s3_logs.s3_bucket_arn}/redshift/example-rc/*"] # Need to add s3_prefix "redshift/${var.name}/*" from the module to the resources.
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }

    principals {
      type        = "AWS"
      identifiers = [data.aws_redshift_service_account.this.arn]
    }
  }
}

module "redshift_cluster" {
  source = "./redshift_module"

  name = "example-rc"

  availability_zones    = ["us-east-1a", "us-east-1b"]
  vpc_cidr              = "10.0.0.0/16"
  private_subnet_cidrs  = ["10.0.0.0/19", "10.0.32.0/19"]
  redshift_subnet_cidrs = ["10.0.128.0/20", "10.0.144.0/20"]

  master_user_name      = "redshift_admin"
  node_type             = "dc2.large"
  number_of_nodes       = 1
  database_name         = "example_database"
  redshift_cluster_port = 8200

  enable_logging_to_s3 = true
  use_own_s3_log       = true
  created_s3_log_name  = "example-rc-logging"

  tags = {
    terraform = true
  }
}