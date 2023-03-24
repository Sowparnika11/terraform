output "key_arn" {
  description = "Key ARN"
  value       = try(aws_kms_key.aws_kms_key.*.arn, null)
}

output "key_id" {
  description = "Key ID"
  value       = try(aws_kms_key.aws_kms_key.*.key_id, null)
}

output "alias_arn" {
  description = "Alias ARN"
  value       = try(aws_kms_alias.aws_kms_alias.*.arn, null)
}

output "alias_name" {
   description = "Alias name"
  value       = try(aws_kms_alias.aws_kms_alias.*.name, null)
}
