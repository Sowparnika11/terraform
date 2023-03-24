# #################################################################################################
# Outputs for Redshift Service Account Data 
# #################################################################################################

output "redshift_service_account_arn" {
  description = "The Redshift Service Account - ARN"
  value       = try(data.aws_redshift_service_account.this[0].arn, "")
}

output "redshift_service_account_id" {
  description = "The Redshift Service Account - ID"
  value       = try(data.aws_redshift_service_account.this[0].id, "")
}

output "redshift_service_account_region" {
  description = "The Redshift Service Account - Region"
  value       = try(data.aws_redshift_service_account.this[0].region, "")
}

# #################################################################################################
# Outputs for IAM Policy Document Data 
# #################################################################################################

output "iam_policy_document_id" {
  description = "The IAM Policy Document - ID"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].id, "")
}

output "iam_policy_document_json" {
  description = "The IAM Policy Document - JSON"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].json, "")
}

output "iam_policy_document_override_json" {
  description = "The IAM Policy Document - Override JSON"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].override_json, "")
}

output "iam_policy_document_override_policy_documents" {
  description = "The IAM Policy Document - Override Policy Documents"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].override_policy_documents, "")
}

output "iam_policy_document_policy_id" {
  description = "The IAM Policy Document - Policy ID"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].policy_id, "")
}

output "iam_policy_document_source_json" {
  description = "The IAM Policy Document - Source JSON"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].source_json, "")
}

output "iam_policy_document_source_policy_documents" {
  description = "The IAM Policy Document - Source Policy Doucments"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].source_policy_documents, "")
}

output "iam_policy_document_statement" {
  description = "The IAM Policy Document - Statement"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].statement, "")
}

output "iam_policy_document_version" {
  description = "The IAM Policy Document - Version"
  value       = try(data.aws_iam_policy_document.s3_redshift[0].version, "")
}

# #################################################################################################
# Outputs for KMS Key for Redshift Resource
# #################################################################################################

output "kms_key_arn" {
  description = "The KMS Key - ARN"
  value       = try(aws_kms_key.redshift_kms_key[0].arn, "")
}

output "kms_key_bypass_policy_lockout_safety_check" {
  description = "The KMS Key - Bypass Policy Lockout Safety Check"
  value       = try(aws_kms_key.redshift_kms_key[0].bypass_policy_lockout_safety_check, "")
}

output "kms_key_custom_key_store_id" {
  description = "The KMS Key - Custom Key Store ID"
  value       = try(aws_kms_key.redshift_kms_key[0].custom_key_store_id, "")
}

output "kms_key_customer_master_key_spec" {
  description = "The KMS Key - Customer Master Key Spec"
  value       = try(aws_kms_key.redshift_kms_key[0].customer_master_key_spec, "")
}

output "kms_key_deletion_window_in_days" {
  description = "The KMS Key - Deletion Window In  Days"
  value       = try(aws_kms_key.redshift_kms_key[0].deletion_window_in_days, "")
}

output "kms_key_description" {
  description = "The KMS Key - Description"
  value       = try(aws_kms_key.redshift_kms_key[0].description, "")
}

output "kms_key_enable_key_rotation" {
  description = "The KMS Key - Enable Key Rotation"
  value       = try(aws_kms_key.redshift_kms_key[0].enable_key_rotation, "")
}

output "kms_key_id" {
  description = "The KMS Key - ID"
  value       = try(aws_kms_key.redshift_kms_key[0].id, "")
}

output "kms_key_is_enabled" {
  description = "The KMS Key - Is Enabled"
  value       = try(aws_kms_key.redshift_kms_key[0].is_enabled, "")
}

output "kms_key_key_id" {
  description = "The KMS Key - Key ID"
  value       = try(aws_kms_key.redshift_kms_key[0].key_id, "")
}

output "kms_key_key_usage" {
  description = "The KMS Key - Key Usage"
  value       = try(aws_kms_key.redshift_kms_key[0].key_usage, "")
}

output "kms_key_multi_region" {
  description = "The KMS Key - Multi Region"
  value       = try(aws_kms_key.redshift_kms_key[0].multi_region, "")
}

output "kms_key_policy" {
  description = "The KMS Key - Policy"
  value       = try(aws_kms_key.redshift_kms_key[0].policy, "")
}

# #################################################################################################
# Outputs for Redshift Subnet Group Endpoint Resource
# #################################################################################################

output "redshift_subnet_group_endpoint_arn" {
  description = "The Redshift Subnet Group - ARN"
  value       = try(aws_redshift_subnet_group.endpoint[0].arn, "")
}

output "redshift_subnet_group_endpoint_description" {
  description = "The Redshift Subnet Group - Description"
  value       = try(aws_redshift_subnet_group.endpoint[0].description, "")
}

output "redshift_subnet_group_endpoint_id" {
  description = "The Redshift Subnet Group - ID"
  value       = try(aws_redshift_subnet_group.endpoint[0].id, "")
}

output "redshift_subnet_group_endpoint_name" {
  description = "The Redshift Subnet Group - Name"
  value       = try(aws_redshift_subnet_group.endpoint[0].name, "")
}

output "redshift_subnet_group_endpoint_subnet_ids" {
  description = "The Redshift Subnet Group - Subnet IDs"
  value       = try(aws_redshift_subnet_group.endpoint[0].subnet_ids, "")
}

# #################################################################################################
# Outputs for VPC Module
# #################################################################################################

output "module_vpc_azs" {
  description = "The VPC - Availability Zones"
  value       = try(module.vpc[0].azs, "")
}

output "module_vpc_default_network_acl_id" {
  description = "The VPC - ACL ID"
  value       = try(module.vpc[0].default_network_acl_id, "")
}

output "module_vpc_default_route_table_id" {
  description = "The VPC - Default Route Table ID"
  value       = try(module.vpc[0].default_route_table_id, "")
}

output "module_vpc_default_security_group_id" {
  description = "The VPC - Default Security Group ID"
  value       = try(module.vpc[0].default_security_group_id, "")
}

output "module_vpc_name" {
  description = "The VPC - Name"
  value       = try(module.vpc[0].name, "")
}

output "module_vpc_private_network_acl_arn" {
  description = "The VPC - Private Network ACL ARN"
  value       = try(module.vpc[0].private_network_acl_arn, "")
}

output "module_vpc_private_network_acl_id" {
  description = "The VPC - Private Network ACL ID"
  value       = try(module.vpc[0].private_network_acl_id, "")
}

output "module_vpc_private_route_table_association_ids" {
  description = "The VPC - Private Route Table Associations IDs"
  value       = try(module.vpc[0].private_route_table_association_ids, "")
}

output "module_vpc_private_route_table_ids" {
  description = "The VPC - Private Route Table IDs"
  value       = try(module.vpc[0].private_route_table_ids, "")
}

output "module_vpc_private_subnet_arns" {
  description = "The VPC - Private Subnet ARNs"
  value       = try(module.vpc[0].private_subnet_arns, "")
}

output "module_vpc_private_subnets" {
  description = "The VPC - Private Subnets"
  value       = try(module.vpc[0].private_subnets, "")
}

output "module_vpc_private_subnets_cidr_blocks" {
  description = "The VPC - Private Subnets CIDR Blocks"
  value       = try(module.vpc[0].private_subnets_cidr_blocks, "")
}

output "module_vpc_redshift_network_acl_arn" {
  description = "The VPC - Reshift Network ACL ARNs"
  value       = try(module.vpc[0].redshift_network_acl_arn, "")
}

output "module_vpc_redshift_network_acl_id" {
  description = "The VPC - Reshift Network ACL ID"
  value       = try(module.vpc[0].redshift_network_acl_id, "")
}

output "module_vpc_redshift_route_table_association_ids" {
  description = "The VPC - Reshift Route Table Association IDs"
  value       = try(module.vpc[0].redshift_route_table_association_ids, "")
}

output "module_vpc_redshift_route_table_ids" {
  description = "The VPC - Reshift Route Table IDs"
  value       = try(module.vpc[0].redshift_route_table_ids, "")
}

output "module_vpc_redshift_subnet_arns" {
  description = "The VPC - Reshift Subnet ARNs"
  value       = try(module.vpc[0].redshift_subnet_arns, "")
}

output "module_vpc_redshift_subnet_group" {
  description = "The VPC - Reshift Subnet Group"
  value       = try(module.vpc[0].redshift_subnet_group, "")
}

output "module_vpc_redshift_subnets" {
  description = "The VPC - Reshift Subnets"
  value       = try(module.vpc[0].redshift_subnets, "")
}

output "module_vpc_redshift_subnets_cidr_blocks" {
  description = "The VPC - Reshift Subnets CIDR Blocks"
  value       = try(module.vpc[0].redshift_subnets_cidr_blocks, "")
}

output "module_vpc_vpc_arn" {
  description = "The VPC - VPC ARN"
  value       = try(module.vpc[0].vpc_arn, "")
}

output "module_vpc_vpc_cidr_block" {
  description = "The VPC - VPC CIDR Block"
  value       = try(module.vpc[0].vpc_cidr_block, "")
}

output "module_vpc_vpc_enable_dns_hostnames" {
  description = "The VPC - VPC Enable DNS Hostnames"
  value       = try(module.vpc[0].vpc_enable_dns_hostnames, "")
}

output "module_vpc_vpc_enable_dns_support" {
  description = "The VPC - VPC Enable DNS Support"
  value       = try(module.vpc[0].vpc_enable_dns_support, "")
}

output "module_vpc_vpc_flow_log_cloudwatch_iam_role_arn" {
  description = "The VPC - VPC Flow Log CloudWatch IAM Role ARN"
  value       = try(module.vpc[0].vpc_flow_log_cloudwatch_iam_role_arn, "")
}

output "module_vpc_vpc_flow_log_destination_arn" {
  description = "The VPC - VPC Flow Log Destination ARN"
  value       = try(module.vpc[0].vpc_flow_log_destination_arn, "")
}

output "module_vpc_vpc_flow_log_destination_type" {
  description = "The VPC - VPC Flow Log Destination Type"
  value       = try(module.vpc[0].vpc_flow_log_destination_type, "")
}

output "module_vpc_vpc_flow_log_id" {
  description = "The VPC - VPC Flow Log ID"
  value       = try(module.vpc[0].vpc_flow_log_id, "")
}

output "module_vpc_vpc_id" {
  description = "The VPC - VPC ID"
  value       = try(module.vpc[0].vpc_id, "")
}

output "module_vpc_vpc_instance_tenancy" {
  description = "The VPC - VPC Instance Tenancy"
  value       = try(module.vpc[0].vpc_instance_tenancy, "")
}

output "module_vpc_vpc_ipv6_association_id" {
  description = "The VPC - VPC IPv6 Association ID"
  value       = try(module.vpc[0].vpc_ipv6_association_id, "")
}

output "module_vpc_vpc_ipv6_cidr_block" {
  description = "The VPC - VPC IPv6 CIDR Block"
  value       = try(module.vpc[0].vpc_ipv6_cidr_block, "")
}

output "module_vpc_vpc_main_route_table_id" {
  description = "The VPC - VPC Main Route Table ID"
  value       = try(module.vpc[0].vpc_main_route_table_id, "")
}

output "module_vpc_vpc_owner_id" {
  description = "The VPC - VPC Owner ID"
  value       = try(module.vpc[0].vpc_owner_id, "")
}

# #################################################################################################
# Outputs for S3 Logs Module
# #################################################################################################

output "module_s3_logs_s3_bucket_arn" {
  description = "The S3 Logs - S3 Bucket ARN"
  value       = try(module.s3_logs[0].s3_bucket_arn, "")
}

output "module_s3_logs_s3_bucket_bucket_domain_name" {
  description = "The S3 Logs - S3 Bucket Bucket Domain Name"
  value       = try(module.s3_logs[0].s3_bucket_bucket_domain_name, "")
}

output "module_s3_logs_s3_bucket_bucket_regional_domain_name" {
  description = "The S3 Logs - S3 Bucket Bucket Regional Domain Name"
  value       = try(module.s3_logs[0].s3_bucket_bucket_regional_domain_name, "")
}

output "module_s3_logs_s3_bucket_hosted_zone_id" {
  description = "The S3 Logs - S3 Bucket Hosted Zone ID"
  value       = try(module.s3_logs[0].s3_bucket_hosted_zone_id, "")
}

output "module_s3_logs_s3_bucket_id" {
  description = "The S3 Logs - S3 Bucket ID"
  value       = try(module.s3_logs[0].s3_bucket_id, "")
}

output "module_s3_logs_s3_bucket_region" {
  description = "The S3 Logs - S3 Bucket Region"
  value       = try(module.s3_logs[0].s3_bucket_region, "")
}

output "module_s3_logs_s3_bucket_website_domain" {
  description = "The S3 Logs - S3 Bucket Website Domain"
  value       = try(module.s3_logs[0].s3_bucket_website_domain, "")
}

output "module_s3_logs_s3_bucket_website_endpoint" {
  description = "The S3 Logs - S3 Bucket Website Endpoint"
  value       = try(module.s3_logs[0].s3_bucket_website_endpoint, "")
}

# #################################################################################################
# Outputs for Redshift Cluster Module
# #################################################################################################

output "module_redshift_authentication_profiles" {
  description = "The Redshift - Authentication Profiles"
  value       = try(module.redshift[0].authentication_profiles, "")
}

output "module_redshift_cluster_arn" {
  description = "The Redshift - Cluster ARN"
  value       = try(module.redshift[0].cluster_arn, "")
}

output "module_redshift_cluster_automated_snapshot_retention_period" {
  description = "The Redshift - Cluster Automated Snapshot Retention Period"
  value       = try(module.redshift[0].cluster_automated_snapshot_retention_period, "")
}

output "module_redshift_cluster_availability_zone" {
  description = "The Redshift - Cluster Availability Zone"
  value       = try(module.redshift[0].cluster_availability_zone, "")
}

output "module_redshift_cluster_database_name" {
  description = "The Redshift - Cluster Database Name"
  value       = try(module.redshift[0].cluster_database_name, "")
}

output "module_redshift_cluster_dns_name" {
  description = "The Redshift - Cluster DNS Name"
  value       = try(module.redshift[0].cluster_dns_name, "")
}

output "module_redshift_cluster_encrypted" {
  description = "The Redshift - Cluster Encrypted"
  value       = try(module.redshift[0].cluster_encrypted, "")
}

output "module_redshift_cluster_endpoint" {
  description = "The Redshift - Cluster Endpoint"
  value       = try(module.redshift[0].cluster_endpoint, "")
}

output "module_redshift_cluster_hostname" {
  description = "The Redshift - Cluster Hostname"
  value       = try(module.redshift[0].cluster_hostname, "")
}

output "module_redshift_cluster_id" {
  description = "The Redshift - Cluster ID"
  value       = try(module.redshift[0].cluster_id, "")
}

output "module_redshift_cluster_identifier" {
  description = "The Redshift - Cluster Identifier"
  value       = try(module.redshift[0].cluster_identifier, "")
}

output "module_redshift_cluster_node_type" {
  description = "The Redshift - Cluster Node Type"
  value       = try(module.redshift[0].cluster_node_type, "")
}

output "module_redshift_cluster_nodes" {
  description = "The Redshift - Cluster Nodes"
  value       = try(module.redshift[0].cluster_nodes, "")
}

output "module_redshift_cluster_parameter_group_name" {
  description = "The Redshift - Cluster Parameter Group Name"
  value       = try(module.redshift[0].cluster_parameter_group_name, "")
}

output "module_redshift_cluster_port" {
  description = "The Redshift - Cluster Port"
  value       = try(module.redshift[0].cluster_port, "")
}

output "module_redshift_cluster_preferred_maintenance_window" {
  description = "The Redshift - Cluster Preferred Maintenance Window"
  value       = try(module.redshift[0].cluster_preferred_maintenance_window, "")
}

output "module_redshift_cluster_public_key" {
  description = "The Redshift - Cluster Public Key"
  value       = try(module.redshift[0].cluster_public_key, "")
}

output "module_redshift_cluster_revision_number" {
  description = "The Redshift - Cluster Revision Number"
  value       = try(module.redshift[0].cluster_revision_number, "")
}

output "module_redshift_cluster_security_groups" {
  description = "The Redshift - Cluster Security Groups"
  value       = try(module.redshift[0].cluster_security_groups, "")
}

output "module_redshift_cluster_subnet_group_name" {
  description = "The Redshift - Cluster Subnet Group Name"
  value       = try(module.redshift[0].cluster_subnet_group_name, "")
}

output "module_redshift_cluster_type" {
  description = "The Redshift - Cluster Type"
  value       = try(module.redshift[0].cluster_type, "")
}

output "module_redshift_cluster_version" {
  description = "The Redshift - Cluster Version"
  value       = try(module.redshift[0].cluster_version, "")
}

output "module_redshift_cluster_vpc_security_group_ids" {
  description = "The Redshift - Cluster VPC Security Group IDs"
  value       = try(module.redshift[0].cluster_vpc_security_group_ids, "")
}

output "module_redshift_endpoint_access_address" {
  description = "The Redshift - Endpoint Access Address"
  value       = try(module.redshift[0].endpoint_access_address, "")
}

output "module_redshift_endpoint_access_id" {
  description = "The Redshift - Endpoint Access ID"
  value       = try(module.redshift[0].endpoint_access_id, "")
}

output "module_redshift_endpoint_access_port" {
  description = "The Redshift - Endpoint Access Port"
  value       = try(module.redshift[0].endpoint_access_port, "")
}

output "module_redshift_endpoint_access_vpc_endpoint" {
  description = "The Redshift - Endpoint Access VPC Endpoint"
  value       = try(module.redshift[0].endpoint_access_vpc_endpoint, "")
}

output "module_redshift_parameter_group_arn" {
  description = "The Redshift - Parameter Group ARN"
  value       = try(module.redshift[0].parameter_group_arn, "")
}

output "module_redshift_parameter_group_id" {
  description = "The Redshift - Parameter Group ID"
  value       = try(module.redshift[0].parameter_group_id, "")
}

output "module_redshift_scheduled_action_iam_role_arn" {
  description = "The Redshift - Scheduled Action IAM Role ARN"
  value       = try(module.redshift[0].scheduled_action_iam_role_arn, "")
}

output "module_redshift_scheduled_action_iam_role_name" {
  description = "The Redshift - Scheduled Action IAM Role Name"
  value       = try(module.redshift[0].scheduled_action_iam_role_name, "")
}

output "module_redshift_scheduled_action_iam_role_unique_id" {
  description = "The Redshift - Scheduled Action IAM Role Unique ID"
  value       = try(module.redshift[0].scheduled_action_iam_role_unique_id, "")
}

output "module_redshift_scheduled_actions" {
  description = "The Redshift - Scheduled Actions"
  value       = try(module.redshift[0].scheduled_actions, "")
}

output "module_redshift_snapshot_schedule_arn" {
  description = "The Redshift - Snapshot Schedule ARN"
  value       = try(module.redshift[0].snapshot_schedule_arn, "")
}

output "module_redshift_subnet_group_arn" {
  description = "The Redshift - Subnet Group ARN"
  value       = try(module.redshift[0].subnet_group_arn, "")
}

output "module_redshift_subnet_group_id" {
  description = "The Redshift - Subnet Group ID"
  value       = try(module.redshift[0].subnet_group_id, "")
}

output "module_redshift_usage_limits" {
  description = "The Redshift - Usage Limits"
  value       = try(module.redshift[0].usage_limits, "")
}