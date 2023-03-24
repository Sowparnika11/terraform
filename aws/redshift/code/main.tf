locals {
  # Locals variables for use in the S3 Log Buckets
  s3_prefix   = "redshift/${var.name}/"
  bucket_name = "${var.name}-redshift-logs"
}

# #################################################################################################
# The VPC and its Resources
# #################################################################################################

module "vpc" {
  count = var.create_all && var.use_own_vpc == false ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "${var.name}-vpc"
  cidr = var.vpc_cidr

  # Block for Availability Zones and Subnets
  azs              = var.availability_zones
  private_subnets  = var.private_subnet_cidrs
  redshift_subnets = var.redshift_subnet_cidrs

  # Subnet Group created in the Redshift Module
  create_redshift_subnet_group = false

  tags = var.tags
}

resource "aws_redshift_subnet_group" "endpoint" {
  count = var.enable_endpoint_access && var.create_all ? 1 : 0

  # Block to connect the Redshift Endpoint to the VPC subnets
  name       = "${var.name}-endpoint"
  subnet_ids = var.use_own_vpc ? var.created_vpc_private_subnet_ids : module.vpc[0].private_subnets

  tags = var.tags
}

module "security_group" {
  count   = var.create_all && var.use_own_vpc == false ? 1 : 0
  source  = "terraform-aws-modules/security-group/aws//modules/redshift"
  version = "~> 4.0"

  # Block to connect Security Groups to the VPC
  name   = "${var.name}-sg"
  vpc_id = module.vpc[0].vpc_id

  # Block for Ingress and Egress Rules
  ingress_rules       = ["redshift-tcp"]
  ingress_cidr_blocks = [module.vpc[0].vpc_cidr_block]
  egress_rules        = ["all-all"]

  tags = var.tags
}

# #################################################################################################
# Resources for the Redshift Module
# #################################################################################################

# ----- IAM Policy for Redshift Logging

data "aws_redshift_service_account" "this" {
  count = var.enable_logging_to_s3 && var.create_all && var.use_own_s3_log == false ? 1 : 0
}

data "aws_iam_policy_document" "s3_redshift" {
  count = var.enable_logging_to_s3 && var.create_all && var.use_own_s3_log == false ? 1 : 0

  statement {
    sid       = "RedshiftAcl"
    actions   = ["s3:GetBucketAcl"]
    resources = [module.s3_logs[0].s3_bucket_arn]

    principals {
      type        = "AWS"
      identifiers = [data.aws_redshift_service_account.this[0].arn]
    }
  }

  statement {
    sid       = "RedshiftWrite"
    actions   = ["s3:PutObject"]
    resources = ["${module.s3_logs[0].s3_bucket_arn}/${local.s3_prefix}*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }

    principals {
      type        = "AWS"
      identifiers = [data.aws_redshift_service_account.this[0].arn]
    }
  }
}

# ----- S3 Log for Redshift Logging

module "s3_logs" {
  count = var.enable_logging_to_s3 && var.create_all && var.use_own_s3_log == false ? 1 : 0

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  # Block for S3 Bucket Details
  bucket = local.bucket_name
  acl    = "log-delivery-write"

  # Block to attach the Policy Document to the S3 Logs
  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_redshift[0].json

  # Block for which Policies, what should be ignored/restrict, and what can be destroyed
  attach_deny_insecure_transport_policy = var.s3_logs_enable_attach_deny_insecure_transport_policy
  force_destroy                         = var.s3_logs_force_destroy
  block_public_acls                     = var.s3_logs_block_public_acls
  block_public_policy                   = var.s3_logs_block_public_policy
  ignore_public_acls                    = var.s3_logs_ignore_public_acls
  restrict_public_buckets               = var.s3_logs_restrict_public_buckets

  tags = var.tags
}

# ----- KMS Key for Redshift Encryption

resource "aws_kms_key" "redshift_kms_key" {
  count = var.enable_encryption_at_rest && var.create_all && var.use_own_kms_key == false ? 1 : 0

  # Block for Different Variables that the KMS Key can have 
  description             = "Managed Key for Encrypting the ${var.name} Redshift Cluster"
  deletion_window_in_days = var.key_deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation

  tags = var.tags
}

# #################################################################################################
# The Redshift Module
# #################################################################################################

module "redshift" {
  count = var.create_all ? 1 : 0

  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 4.0"

  cluster_identifier = var.name

  # Block for the Size and Number of Nodes in the Redshift Cluster
  node_type       = var.node_type
  number_of_nodes = var.number_of_nodes

  # Block for Accessing the Database
  database_name          = var.database_name
  master_username        = var.master_user_name
  create_random_password = var.enable_random_password
  master_password        = var.master_user_password
  port                   = var.redshift_cluster_port

  # Block for Encrypting the Redshift Cluster
  encrypted   = var.enable_encryption_at_rest
  kms_key_arn = var.enable_encryption_at_rest && var.use_own_kms_key == false ? aws_kms_key.redshift_kms_key[0].arn : var.enable_encryption_at_rest && var.use_own_kms_key ? var.created_kms_key_arn : null

  # Block for Connecting the Redshift Cluster to the VPC
  enhanced_vpc_routing   = var.enable_enhanced_vpc_routing
  vpc_security_group_ids = var.use_own_vpc ? [var.created_vpc_security_group_id] : [module.security_group[0].security_group_id]
  subnet_ids             = var.use_own_vpc ? var.created_vpc_redshift_subnet_ids : module.vpc[0].redshift_subnets

  # Block for Inputs that can be either True of False
  availability_zone_relocation_enabled = var.enable_availability_zone_relocation
  publicly_accessible                  = var.make_redshift_publicly_accessible
  allow_version_upgrade                = var.allow_version_upgrade

  # Block for Inputs that need complex Map variables
  create_scheduled_action_iam_role = length(var.scheduled_actions) > 0 ? true : false
  scheduled_actions                = var.scheduled_actions
  usage_limits                     = var.usage_limits
  authentication_profiles          = var.authentication_profiles

  # Block for Creating an S3 Log Bucket for the Redshift Cluster
  logging = {
    enable        = var.enable_logging_to_s3
    bucket_name   = var.enable_logging_to_s3 && var.use_own_s3_log == false ? local.bucket_name : var.enable_logging_to_s3 && var.use_own_s3_log ? var.created_s3_log_name : null
    s3_key_prefix = local.s3_prefix
  }

  # Block for Creating a Custom Subnet for the Redshift Cluster
  subnet_group_name        = "${var.name}-subnet"
  subnet_group_description = "Custom Subnet for ${var.name} Cluster"
  subnet_group_tags = {
    Additional = "CustomSubnetGroup"
  }

  # Block for Creating a Custom Parameter Group for the Redshift Cluster
  parameter_group_name        = "${var.name}-parameters"
  parameter_group_description = "Custom parameter group for the ${var.name} Cluster"
  parameter_group_parameters  = var.parameters
  parameter_group_tags = {
    Additional = "CustomParameterGroup"
  }

  # Block for Creating an Endpoint for the Redshift Cluster
  create_endpoint_access          = var.enable_endpoint_access
  endpoint_name                   = "${var.name}-endpoint"
  endpoint_subnet_group_name      = length(aws_redshift_subnet_group.endpoint) > 0 ? aws_redshift_subnet_group.endpoint[0].id : null
  endpoint_vpc_security_group_ids = var.use_own_vpc ? [var.created_vpc_security_group_id] : [module.security_group[0].security_group_id]

  # Block for Creating the Redshift Snapshot Schedule
  create_snapshot_schedule        = var.enable_snapshot_schedule
  snapshot_schedule_identifier    = var.name
  use_snapshot_identifier_prefix  = true
  snapshot_schedule_description   = "The schedule for the snapshots, for the ${var.name}, to take place."
  snapshot_schedule_definitions   = var.snapshot_schedule_definition
  snapshot_schedule_force_destroy = var.snapshot_schedule_force_destroy

  tags = var.tags
}