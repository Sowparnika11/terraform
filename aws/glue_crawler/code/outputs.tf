# #################################################################################################
# Outputs for the IAM Policy 
# #################################################################################################

output "iam_policy_arn" {
  description = "The IAM Policy - ARN"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].arn, "")
}

output "iam_policy_description" {
  description = "The IAM Policy - Description"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].description, "")
}

output "iam_policy_id" {
  description = "The IAM Policy - ID"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].id, "")
}

output "iam_policy_name" {
  description = "The IAM Policy - Name"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].name, "")
}

output "iam_policy_path" {
  description = "The IAM Policy - Path"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].path, "")
}

output "iam_policy_path_prefix" {
  description = "The IAM Policy - Path Prefix"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].path_prefix, "")
}

output "iam_policy_policy" {
  description = "The IAM Policy - Policy"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].policy, "")
}

output "iam_policy_policy_id" {
  description = "The IAM Policy - Policy ID"
  value       = try(data.aws_iam_policy.glue_console_full_access[0].policy_id, "")
}

# #################################################################################################
# Outputs for the IAM Role 
# #################################################################################################

output "iam_role_arn" {
  description = "The IAM Role - ARN"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "iam_role_assume_role_policy" {
  description = "The IAM Role - Assume Role Policy"
  value       = try(aws_iam_role.this[0].assume_role_policy, "")
}

output "iam_role_create_date" {
  description = "The IAM Role - Create Date"
  value       = try(aws_iam_role.this[0].create_date, "")
}

output "iam_role_description" {
  description = "The IAM Role - Description"
  value       = try(aws_iam_role.this[0].description, "")
}

output "iam_role_force_detach_policies" {
  description = "The IAM Role - Detach Policies"
  value       = try(aws_iam_role.this[0].force_detach_policies, "")
}

output "iam_role_id" {
  description = "The IAM Role - ID"
  value       = try(aws_iam_role.this[0].id, "")
}

output "iam_role_managed_policy_arns" {
  description = "The IAM Role - Policy ARNs"
  value       = try(aws_iam_role.this[0].managed_policy_arns, "")
}

output "iam_role_max_session_duration" {
  description = "The IAM Role - Session Duration"
  value       = try(aws_iam_role.this[0].max_session_duration, "")
}

output "iam_role_name" {
  description = "The IAM Role - Name"
  value       = try(aws_iam_role.this[0].name, "")
}

output "iam_role_name_prefix" {
  description = "The IAM Role - Name Prefix"
  value       = try(aws_iam_role.this[0].name_prefix, "")
}

output "iam_role_path" {
  description = "The IAM Role - Path"
  value       = try(aws_iam_role.this[0].path, "")
}

output "iam_role_permissions_boundary" {
  description = "The IAM Role - Permissions Boundary"
  value       = try(aws_iam_role.this[0].permissions_boundary, "")
}

output "iam_role_unique_id" {
  description = "The IAM Role - Unique ID"
  value       = try(aws_iam_role.this[0].unique_id, "")
}

# #################################################################################################
# Outputs for the IAM Role Policy Attachment
# #################################################################################################

output "iam_role_policy_attachment_id" {
  description = "The IAM Role Policy Attachment - ID"
  value       = try(aws_iam_role_policy_attachment.this[0].id, "")
}

output "iam_role_policy_attachment_policy_arn" {
  description = "The IAM Role Policy Attachment - ARN"
  value       = try(aws_iam_role_policy_attachment.this[0].policy_arn, "")
}

output "iam_role_policy_attachment_role" {
  description = "The IAM Role Policy Attachment - Role"
  value       = try(aws_iam_role_policy_attachment.this[0].role, "")
}

# #################################################################################################
# Outputs for the Glue Catalog Database 
# #################################################################################################

output "catalog_database_arn" {
  description = "The Catalog Database - ARN"
  value       = try(aws_glue_catalog_database.this[0].arn, "")
}

output "catalog_database_catalog_id" {
  description = "The Catalog Database - Catalog ID"
  value       = try(aws_glue_catalog_database.this[0].catalog_id, "")
}

output "catalog_database_create_table_default_permission" {
  description = "The Catalog Database - Create Table Default Permission"
  value       = try(aws_glue_catalog_database.this[0].create_table_default_permission, "")
}

output "catalog_database_description" {
  description = "The Catalog Database - Description"
  value       = try(aws_glue_catalog_database.this[0].description, "")
}

output "catalog_database_id" {
  description = "The Catalog Database - ID"
  value       = try(aws_glue_catalog_database.this[0].id, "")
}

output "catalog_database_location_uri" {
  description = "The Catalog Database - Location URI"
  value       = try(aws_glue_catalog_database.this[0].location_uri, "")
}

output "catalog_database_name" {
  description = "The Catalog Database - Name"
  value       = try(aws_glue_catalog_database.this[0].name, "")
}

output "catalog_database_parameters" {
  description = "The Catalog Database - Parameters"
  value       = try(aws_glue_catalog_database.this[0].parameters, "")
}

output "catalog_database_target_database" {
  description = "The Catalog Database - Target Database"
  value       = try(aws_glue_catalog_database.this[0].target_database, "")
}

# #################################################################################################
# Outputs for the Glue Crawler 
# #################################################################################################

output "crawler_arn" {
  description = "The Crawler - ARN"
  value       = try(aws_glue_crawler.this[*].arn, "")
}

output "crawler_classifiers" {
  description = "The Crawler - Classifiers"
  value       = try(aws_glue_crawler.this[*].classifiers, "")
}

output "crawler_configuration" {
  description = "The Crawler - Configuration"
  value       = try(aws_glue_crawler.this[*].configuration, "")
}

output "crawler_database_name" {
  description = "The Crawler - Name"
  value       = try(aws_glue_crawler.this[*].database_name, "")
}

output "crawler_description" {
  description = "The Crawler - Description"
  value       = try(aws_glue_crawler.this[*].description, "")
}

output "crawler_id" {
  description = "The Crawler - ID"
  value       = try(aws_glue_crawler.this[*].id, "")
}

output "crawler_name" {
  description = "The Crawler - Name"
  value       = try(aws_glue_crawler.this[*].name, "")
}

output "crawler_role" {
  description = "The Crawler - Role"
  value       = try(aws_glue_crawler.this[*].role, "")
}

output "crawler_schedule" {
  description = "The Crawler - Schedule"
  value       = try(aws_glue_crawler.this[*].schedule, "")
}

output "crawler_security_configuration" {
  description = "The Crawler - Security Configuration"
  value       = try(aws_glue_crawler.this[*].security_configuration, "")
}

output "crawler_table_prefix" {
  description = "The Crawler - Table Prefix"
  value       = try(aws_glue_crawler.this[*].table_prefix, "")
}