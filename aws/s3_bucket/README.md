AWS EC2 Terraform module
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)
Amazon Simple Storage Service (Amazon S3) is an object storage service that offers industry-leading scalability, data availability, security, and performance. Customers of all sizes and industries can use Amazon S3 to store and protect any amount of data for a range of use cases, such as data lakes, websites, mobile applications, backup and restore, archive, enterprise applications, IoT devices, and big data analytics.Amazon S3 offers a range of storage classes designed for different use cases.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Examples
- With minimum parameters
   ```hcl
   module "s3_bucket_creation" {
    source               = "./s3_template"
    is_s3                = true
    name                 = "sample-bucket"
    tags                 = {"purpose" = "purpose of the bucket"}
    region               = "eu-west-2"
    log_bucket_name      = "log-bucket"
   }
   ```
- With all parameters
  ```hcl 
  module "s3_bucket_creation" {
    source                       = "./s3_template"
    is_s3                        = true
    name                         = "sample-bucket"
    tags                         = {"purpose" = "purpose of the bucket"}
    region                       = "eu-west-2"
    acl                          = "private"
    log_bucket_name              = "log-bucket"
    status                       = "Enabled"
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
    log_sse_algorithm            = "aws:kms"
    create                       = false
    retention_in_days            = 7
   }

   ```

## Requirements

| Name  | Version |
| ----- | ------- |
| Terraform | >= 0.13 |
| Aws  | >= 4.13.0 |

## Providers

| Name  | Version |
| ----- | ------- |
| Aws  | >= 4.13.0 |

## Resource

| Name | Type |
|----- | ---- |
| aws_s3_bucket.sample_bucket | Resource |
| aws_s3_bucket_acl.sample_bucket_acl | Resource |
| aws_s3_bucket_versioning.versioning_sample| Resource |
| aws_s3_bucket_public_access_block.public_access | Resource|
| aws_kms_key.sample_key| Resource |
| aws_kms_alias.s3_alias | Resource|
| aws_s3_bucket_server_side_encryption_configuration.example | Resource|
| aws_s3_bucket.log_bucket | Resource|
| aws_s3_bucket_public_access_block.log_access| Resource |
| aws_s3_bucket_versioning.log_versioning| Resource |
| aws_s3_bucket_acl.log_bucket_acl| Resource |
| aws_kms_key.log_key | Resource |
| aws_kms_alias.log_alias| Resource |
| aws_cloudwatch_log_group.cloudwatch_log_group| Resource |

## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| name | The name of the bucket. If omitted, Terraform will assign a random, unique name. | `string` | Null | Yes |
| create_s3 | to decide whether s3 is to be created or not | `bool` | yes | Yes|
| region | location of the aws region | `string` | Null | Yes|
| tags | A mapping of tags to assign to the bucket. | `map(string)` | {} | No|
| acl_value| (Optional, Conflicts with access_control_policy) The canned ACL to apply to the bucket | `string` | Null | No|
| versioning_status | Configuration block for the versioning parameters to decide whether versioning should be enabled or not| `string` | Enabled, Suspended, or Disabled | Yes|
| block_public_acls |Whether Amazon S3 should block public ACLs for this bucket| `bool` | False | No|
| block_public_policy | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | False | No|
| restrict_public_buckets | Whether Amazon S3 should restrict public bucket policies for this bucket | `bool` | False | No|
| ignore_public_acls | Whether Amazon S3 should ignore public ACLs for this bucket | `bool` | False | No|
| description | The description of the key as viewed in AWS console | `string` | NA | No|
| deletion_window_in_days | Duration in days after which the key is deleted after destruction of the resource | `number` | 7 | No|
| enable_key_rotation | Specifies whether key rotation is enabled | `bool` | True | No|
| name | The display name of the alias. The name must start with the word "alias" followed by a forward slash (alias/) | `string` | NA | No|
| target_key_id | Identifier for the key for which the alias is for, can be either an ARN or key_id | `string` | NA | Yes|
| kms_master_key_id | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms | `string` | "" | No|
| sse_algorithm  | The server-side encryption algorithm to use.Valid values are AES256 and aws:kms | `string` | "aws:kms"  | No|
| create | to decide whether S3 bucket cloud watch log needs to be created or not | `bool` | False | No |
| retention_in_days |Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire | `number` | 7 | No |


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)