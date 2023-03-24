# A Terraform Template for Creating a Redshift Cluster.

This Terraform Redshift Cluster Template was build from [this Redshift Module](https://registry.terraform.io/modules/terraform-aws-modules/redshift/aws/latest), [this VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest), [this Security Group Module](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest), and [this S3 Bucket Module](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest). This Module creates a single Redshift Cluster with associate Resources. Like a VPC, a S3 Bucket, for Logs, or a KMS Key, for Encryption. You can also choose to connect your own Resources created outside the Module for the Redshift Cluster to use. By default both Logging to an S3 Bucket and Encrypting with a KMS key are turned on. 

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Examples

- This is an example of the Module with the Minimum Number of Variables for the Redshift Cluster to work without outside Resources.

```
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
}
```

- This is an example of the Module with the Maximum Number of Variables for the Redshift Cluster to work without outside Resources.

```
module "redshift_cluster" {
  source = "./redshift_module"

  create_all = true
  name       = "test-rc"

  use_own_kms_key     = false
  created_kms_key_arn = ""

  use_own_s3_log      = false
  created_s3_log_name = ""

  use_own_vpc                     = false
  created_vpc_private_subnet_ids  = []
  created_vpc_redshift_subnet_ids = []
  created_vpc_security_group_id   = ""

  enable_enhanced_vpc_routing = true
  availability_zones          = ["us-east-1a", "us-east-1b"]
  vpc_cidr                    = "10.0.0.0/16"
  private_subnet_cidrs        = ["10.0.0.0/19", "10.0.32.0/19"]
  redshift_subnet_cidrs       = ["10.0.128.0/20", "10.0.144.0/20"]

  enable_logging_to_s3                                 = true
  s3_logs_enable_attach_deny_insecure_transport_policy = true
  s3_logs_force_destroy                                = true
  s3_logs_block_public_acls                            = true
  s3_logs_block_public_policy                          = true
  s3_logs_ignore_public_acls                           = true
  s3_logs_restrict_public_buckets                      = true

  enable_encryption_at_rest   = true
  key_deletion_window_in_days = 14
  enable_key_rotation         = true

  master_user_name       = "redshift_example_admin"
  enable_random_password = true
  master_user_password   = ""

  node_type       = "dc2.large"
  number_of_nodes = 1

  database_name         = "example_database"
  maintenance_window    = "sat:05:00-sat:05:30"
  redshift_cluster_port = 8200

  enable_availability_zone_relocation = false
  enable_endpoint_access              = false

  allow_version_upgrade             = true
  make_redshift_publicly_accessible = false

  enable_snapshot_schedule        = true
  snapshot_schedule_definition    = ["rate(12 hours)"]
  snapshot_schedule_force_destroy = true

  parameters = {
    enable_user_activity_logging = {
      name  = "enable_user_activity_logging",
      value = "true"
    },
    max_concurrency_scaling_clusters = {
      name  = "max_concurrency_scaling_clusters",
      value = "3"
    }
  }

  scheduled_actions = {
    pause = {
      name          = "example-pause"
      description   = "Pause Cluster Every Night"
      schedule      = "cron(0 22 * * ? *)"
      pause_cluster = "true"
    }
    resize = {
      name        = "example-resize"
      description = "Resize Cluster (Demo Only)"
      schedule    = "cron(00 13 * * ? *)"
      resize_cluster = {
        node_type       = "ds2.xlarge"
        number_of_nodes = "5"
      }
    }
    resume = {
      name           = "example-resume"
      description    = "Resume Cluster Every Morning"
      schedule       = "cron(0 12 * * ? *)"
      resume_cluster = "true"
    }
  }

  usage_limits = {
    currency_scaling = {
      feature_type  = "concurrency-scaling"
      limit_type    = "time"
      amount        = "60"
      breach_action = "emit-metric"
    }
    spectrum = {
      feature_type  = "spectrum"
      limit_type    = "data-scanned"
      amount        = "2"
      breach_action = "disable"
      tags = {
        Additional = "CustomUsageLimits"
      }
    }
    cross_region_datasharing = {
      feature_type = "cross-region-datasharing"
      limit_type   = "data-scanned"
      amount       = "4"
      period       = "weekly"
    }
  }

  authentication_profiles = {
    example = {
      name = "example"
      content = {
        AllowDBUserOverride = "1"
        Client_ID           = "ExampleClientID"
        App_ID              = "example"
      }
    }
  }

  tags = {
    terraform = true
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redshift"></a> [redshift](#module\_redshift) | terraform-aws-modules/redshift/aws | ~> 4.0 |
| <a name="module_s3_logs"></a> [s3\_logs](#module\_s3\_logs) | terraform-aws-modules/s3-bucket/aws | ~> 3.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws//modules/redshift | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.redshift_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_redshift_subnet_group.endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_iam_policy_document.s3_redshift](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_redshift_service_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/redshift_service_account) | data source |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| <a name="input_allow_version_upgrade"></a> [allow\_version\_upgrade](#input\_allow\_version\_upgrade) | If True, major version upgrades can be applied during the Maintenance Window to the Amazon Redshift engine that is running on the Cluster. | `bool` | `true` |
| <a name="input_authentication_profiles"></a> [authentication\_profiles](#input\_authentication\_profiles) | Map of Authentication Profiles to create. | `any` | `{}` |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of Availability Zones to use for the Subnets in the VPC. | `list(string)` | `[]` |
| <a name="input_create_all"></a> [create\_all](#input\_create\_all) | Switch to turn the Module on or off. | `bool` | `true` |
| <a name="input_created_kms_key_arn"></a> [created\_kms\_key\_arn](#input\_created\_kms\_key\_arn) | ARN of KMS Key. Variable used if you create a KMS Key outside the Module. Needs enable\_encryption\_at\_rest and use\_own\_kms\_key to be set to True. | `string` | `""` |
| <a name="input_created_s3_log_name"></a> [created\_s3\_log\_name](#input\_created\_s3\_log\_name) | Name of S3 Bucket you want Logs to be stored in. Variable used if you create a S3 Log outside the Module. Needs enable\_logging\_to\_s3 and use\_own\_s3\_log to be set to True. | `string` | `""` |        
| <a name="input_created_vpc_private_subnet_ids"></a> [created\_vpc\_private\_subnet\_ids](#input\_created\_vpc\_private\_subnet\_ids) | VPC Private Subnet IDs you want the Redshift Cluster to be connected to. Variable used if you create a VPC outside the Module. Needs use\_own\_vpc to be set to True. | `list(string)` | `[]` |
| <a name="input_created_vpc_redshift_subnet_ids"></a> [created\_vpc\_redshift\_subnet\_ids](#input\_created\_vpc\_redshift\_subnet\_ids) | VPC Redshift Subnet IDs you want the Redshift Cluster to be connected to. Variable used if you create a VPC outside the Module. Needs use\_own\_vpc to be set to True. | `list(string)` | `[]` |
| <a name="input_created_vpc_security_group_id"></a> [created\_vpc\_security\_group\_id](#input\_created\_vpc\_security\_group\_id) | Name of S3 Bucket you want logs to be stored in. Variable used if you create a VPC outside the module. Needs use\_own\_vpc to be set to True. | `string` | `""` |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the first Database to be created when the Cluster is created. | `string` | `"test_database"` |
| <a name="input_enable_availability_zone_relocation"></a> [enable\_availability\_zone\_relocation](#input\_enable\_availability\_zone\_relocation) | Enables of Disables Availability Zone Relocation. To enable, select True. Only available when using ra3.x type. | `bool` | `false` |
| <a name="input_enable_encryption_at_rest"></a> [enable\_encryption\_at\_rest](#input\_enable\_encryption\_at\_rest) | Enables or Disables Encryption at Rest of the Redshift Cluster. | `bool` | `true` |
| <a name="input_enable_endpoint_access"></a> [enable\_endpoint\_access](#input\_enable\_endpoint\_access) | Enables or Disables Endpoint Access. To enable, select True. Only available when the enable\_availability\_zone\_relocation variable is set to True. | `bool` | `false` |
| <a name="input_enable_enhanced_vpc_routing"></a> [enable\_enhanced\_vpc\_routing](#input\_enable\_enhanced\_vpc\_routing) | Enables or Disables Enhanced VPC Routing for the Redshift Cluster. | `bool` | `true` |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Allows for the rotation of KMS Keys for the Redshift Cluster. | `bool` | `true` |
| <a name="input_enable_logging_to_s3"></a> [enable\_logging\_to\_s3](#input\_enable\_logging\_to\_s3) | Enables or Disables logging to an S3 Bucket. To Enable Logging, select True. | `bool` | `true` |
| <a name="input_enable_random_password"></a> [enable\_random\_password](#input\_enable\_random\_password) | Enables or Disables the creating and use of a Random Password. | `bool` | `true` |
| <a name="input_enable_snapshot_schedule"></a> [enable\_snapshot\_schedule](#input\_enable\_snapshot\_schedule) | Enables or Disables the Snapshot Schedule Feature. To enable, select True. | `bool` | `false` |
| <a name="input_key_deletion_window_in_days"></a> [key\_deletion\_window\_in\_days](#input\_key\_deletion\_window\_in\_days) | The amount of days the KMS key for the Redshift Cluster will be used before deletion. | `number` | `30` |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The maintenance window for the Redshift Cluster. | `string` | `""` |
| <a name="input_make_redshift_publicly_accessible"></a> [make\_redshift\_publicly\_accessible](#input\_make\_redshift\_publicly\_accessible) | Specifies whether Amazon Redshift will be Publicly Accessible. | `bool` | `false` |
| <a name="input_master_user_name"></a> [master\_user\_name](#input\_master\_user\_name) | The Username that is associated with the Master User Account for the Cluster that is being created. Must start with a-z and contain only a-z or 0-9. | `string` | n/a |
| <a name="input_master_user_password"></a> [master\_user\_password](#input\_master\_user\_password) | The Password that is associated with the Master User Account for the Cluster that is being created. Set enable\_random\_password to True, to ignore this variable. Must have at least 8 Characters and no more than 64 Characters, and must include 1 Uppercase Letter, 1 Lowercase Letter, 1 Number, and 1 Symbol (excluding / @ " '). | `string` | `null` |
| <a name="input_name"></a> [name](#input\_name) | Name for all the Resources, the module will add suffixes for the different Resources. | `string` | n/a |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The type of Node to be provisioned. | `string` | n/a |
| <a name="input_number_of_nodes"></a> [number\_of\_nodes](#input\_number\_of\_nodes) | The number of compute nodes in the Cluster. For Multi-Node Clusters, the number\_of\_nodes variable must be greater than 1. | `number` | n/a |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A List of Parameters that you can use for the Redshift Cluster. | `any` | `{}` |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDR Block for Private Subnets, located in the Availability Zones. CIDR Block parameter must be in the form x.x.x.x/16-28. | `list(string)` | `[]` |
| <a name="input_redshift_cluster_port"></a> [redshift\_cluster\_port](#input\_redshift\_cluster\_port) | The Port Number on which the Cluster accepts incoming connections. | `number` | n/a |
| <a name="input_redshift_subnet_cidrs"></a> [redshift\_subnet\_cidrs](#input\_redshift\_subnet\_cidrs) | CIDR Block for Redshift Subnets, located in the Availability Zones. CIDR Block parameter must be in the form x.x.x.x/16-28. | `list(string)` | `[]` |
| <a name="input_s3_logs_block_public_acls"></a> [s3\_logs\_block\_public\_acls](#input\_s3\_logs\_block\_public\_acls) | Whether Amazon S3 should block Public ACLs for the S3 Logs Bucket. | `bool` | `true` |
| <a name="input_s3_logs_block_public_policy"></a> [s3\_logs\_block\_public\_policy](#input\_s3\_logs\_block\_public\_policy) | Whether Amazon S3 should block Public Bucket Policies for the S3 Logs Bucket. | `bool` | `true` |
| <a name="input_s3_logs_enable_attach_deny_insecure_transport_policy"></a> [s3\_logs\_enable\_attach\_deny\_insecure\_transport\_policy](#input\_s3\_logs\_enable\_attach\_deny\_insecure\_transport\_policy) | Controls if S3 Logs Bucket should have deny Non-SSL Transport Policy attached. | `bool` | `true` |
| <a name="input_s3_logs_force_destroy"></a> [s3\_logs\_force\_destroy](#input\_s3\_logs\_force\_destroy) | A Boolean that indicates all objects should be deleted from the S3 Logs Bucket so that the Bucket can be destroyed without error. These objects are not recoverable. | `bool` | `true` |
| <a name="input_s3_logs_ignore_public_acls"></a> [s3\_logs\_ignore\_public\_acls](#input\_s3\_logs\_ignore\_public\_acls) | Whether Amazon S3 should ignore Public ACLs for the S3 Logs Bucket. | `bool` | `true` |
| <a name="input_s3_logs_restrict_public_buckets"></a> [s3\_logs\_restrict\_public\_buckets](#input\_s3\_logs\_restrict\_public\_buckets) | Whether Amazon S3 should restrict Public Bucket Policies for the S3 Logs Bucket. | `bool` | `true` |
| <a name="input_scheduled_actions"></a> [scheduled\_actions](#input\_scheduled\_actions) | A map of maps containing Scheduled Action details. | `any` | `{}` |
| <a name="input_snapshot_schedule_definition"></a> [snapshot\_schedule\_definition](#input\_snapshot\_schedule\_definition) | The amount of the time between each Snapshot. | `list(string)` | `[]` |
| <a name="input_snapshot_schedule_force_destroy"></a> [snapshot\_schedule\_force\_destroy](#input\_snapshot\_schedule\_force\_destroy) | Whether to destroy all associated Clusters with this Snapshot Schedule on deletion. Must be enabled and applied before attempting deletion. | `bool` | `true` |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for all the Resources. | `map(any)` | `{}` |
| <a name="input_usage_limits"></a> [usage\_limits](#input\_usage\_limits) | Map of Usage Limit defintions to create. | `any` | `{}` |
| <a name="input_use_own_kms_key"></a> [use\_own\_kms\_key](#input\_use\_own\_kms\_key) | Specifies whether the User has created a KMS Key outside the Module, to use for the Redshift Cluster. | `bool` | `false` |
| <a name="input_use_own_s3_log"></a> [use\_own\_s3\_log](#input\_use\_own\_s3\_log) | Specifies whether the User has created a S3 Log outside the Module, to use for the Redshift Cluster. | `bool` | `false` |
| <a name="input_use_own_vpc"></a> [use\_own\_vpc](#input\_use\_own\_vpc) | Specifies whether the user has created a VPC outside the Module, to use for the Redshift Cluster. | `bool` | `false` |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR Block for the VPC. CIDR Block parameter must be in the form x.x.x.x/16-28. | `string` | `""` |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_document_id"></a> [iam\_policy\_document\_id](#output\_iam\_policy\_document\_id) | The IAM Policy Document - ID |
| <a name="output_iam_policy_document_json"></a> [iam\_policy\_document\_json](#output\_iam\_policy\_document\_json) | The IAM Policy Document - JSON |
| <a name="output_iam_policy_document_override_json"></a> [iam\_policy\_document\_override\_json](#output\_iam\_policy\_document\_override\_json) | The IAM Policy Document - Override JSON |
| <a name="output_iam_policy_document_override_policy_documents"></a> [iam\_policy\_document\_override\_policy\_documents](#output\_iam\_policy\_document\_override\_policy\_documents) | The IAM Policy Document - Override Policy Documents |
| <a name="output_iam_policy_document_policy_id"></a> [iam\_policy\_document\_policy\_id](#output\_iam\_policy\_document\_policy\_id) | The IAM Policy Document - Policy ID |
| <a name="output_iam_policy_document_source_json"></a> [iam\_policy\_document\_source\_json](#output\_iam\_policy\_document\_source\_json) | The IAM Policy Document - Source JSON |
| <a name="output_iam_policy_document_source_policy_documents"></a> [iam\_policy\_document\_source\_policy\_documents](#output\_iam\_policy\_document\_source\_policy\_documents) | The IAM Policy Document - Source Policy Doucments |
| <a name="output_iam_policy_document_statement"></a> [iam\_policy\_document\_statement](#output\_iam\_policy\_document\_statement) | The IAM Policy Document - Statement |
| <a name="output_iam_policy_document_version"></a> [iam\_policy\_document\_version](#output\_iam\_policy\_document\_version) | The IAM Policy Document - Version |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The KMS Key - ARN |
| <a name="output_kms_key_bypass_policy_lockout_safety_check"></a> [kms\_key\_bypass\_policy\_lockout\_safety\_check](#output\_kms\_key\_bypass\_policy\_lockout\_safety\_check) | The KMS Key - Bypass Policy Lockout Safety Check |
| <a name="output_kms_key_custom_key_store_id"></a> [kms\_key\_custom\_key\_store\_id](#output\_kms\_key\_custom\_key\_store\_id) | The KMS Key - Custom Key Store ID |
| <a name="output_kms_key_customer_master_key_spec"></a> [kms\_key\_customer\_master\_key\_spec](#output\_kms\_key\_customer\_master\_key\_spec) | The KMS Key - Customer Master Key Spec |
| <a name="output_kms_key_deletion_window_in_days"></a> [kms\_key\_deletion\_window\_in\_days](#output\_kms\_key\_deletion\_window\_in\_days) | The KMS Key - Deletion Window In  Days |
| <a name="output_kms_key_description"></a> [kms\_key\_description](#output\_kms\_key\_description) | The KMS Key - Description |
| <a name="output_kms_key_enable_key_rotation"></a> [kms\_key\_enable\_key\_rotation](#output\_kms\_key\_enable\_key\_rotation) | The KMS Key - Enable Key Rotation |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The KMS Key - ID |
| <a name="output_kms_key_is_enabled"></a> [kms\_key\_is\_enabled](#output\_kms\_key\_is\_enabled) | The KMS Key - Is Enabled |
| <a name="output_kms_key_key_id"></a> [kms\_key\_key\_id](#output\_kms\_key\_key\_id) | The KMS Key - Key ID |
| <a name="output_kms_key_key_usage"></a> [kms\_key\_key\_usage](#output\_kms\_key\_key\_usage) | The KMS Key - Key Usage |
| <a name="output_kms_key_multi_region"></a> [kms\_key\_multi\_region](#output\_kms\_key\_multi\_region) | The KMS Key - Multi Region |
| <a name="output_kms_key_policy"></a> [kms\_key\_policy](#output\_kms\_key\_policy) | The KMS Key - Policy |
| <a name="output_module_redshift_authentication_profiles"></a> [module\_redshift\_authentication\_profiles](#output\_module\_redshift\_authentication\_profiles) | The Redshift - Authentication Profiles |
| <a name="output_module_redshift_cluster_arn"></a> [module\_redshift\_cluster\_arn](#output\_module\_redshift\_cluster\_arn) | The Redshift - Cluster ARN |
| <a name="output_module_redshift_cluster_automated_snapshot_retention_period"></a> [module\_redshift\_cluster\_automated\_snapshot\_retention\_period](#output\_module\_redshift\_cluster\_automated\_snapshot\_retention\_period) | The Redshift - Cluster Automated Snapshot Retention Period |
| <a name="output_module_redshift_cluster_availability_zone"></a> [module\_redshift\_cluster\_availability\_zone](#output\_module\_redshift\_cluster\_availability\_zone) | The Redshift - Cluster Availability Zone |
| <a name="output_module_redshift_cluster_database_name"></a> [module\_redshift\_cluster\_database\_name](#output\_module\_redshift\_cluster\_database\_name) | The Redshift - Cluster Database Name |
| <a name="output_module_redshift_cluster_dns_name"></a> [module\_redshift\_cluster\_dns\_name](#output\_module\_redshift\_cluster\_dns\_name) | The Redshift - Cluster DNS Name |
| <a name="output_module_redshift_cluster_encrypted"></a> [module\_redshift\_cluster\_encrypted](#output\_module\_redshift\_cluster\_encrypted) | The Redshift - Cluster Encrypted |
| <a name="output_module_redshift_cluster_endpoint"></a> [module\_redshift\_cluster\_endpoint](#output\_module\_redshift\_cluster\_endpoint) | The Redshift - Cluster Endpoint |
| <a name="output_module_redshift_cluster_hostname"></a> [module\_redshift\_cluster\_hostname](#output\_module\_redshift\_cluster\_hostname) | The Redshift - Cluster Hostname |
| <a name="output_module_redshift_cluster_id"></a> [module\_redshift\_cluster\_id](#output\_module\_redshift\_cluster\_id) | The Redshift - Cluster ID |
| <a name="output_module_redshift_cluster_identifier"></a> [module\_redshift\_cluster\_identifier](#output\_module\_redshift\_cluster\_identifier) | The Redshift - Cluster Identifier |
| <a name="output_module_redshift_cluster_node_type"></a> [module\_redshift\_cluster\_node\_type](#output\_module\_redshift\_cluster\_node\_type) | The Redshift - Cluster Node Type |
| <a name="output_module_redshift_cluster_nodes"></a> [module\_redshift\_cluster\_nodes](#output\_module\_redshift\_cluster\_nodes) | The Redshift - Cluster Nodes |
| <a name="output_module_redshift_cluster_parameter_group_name"></a> [module\_redshift\_cluster\_parameter\_group\_name](#output\_module\_redshift\_cluster\_parameter\_group\_name) | The Redshift - Cluster Parameter Group Name |
| <a name="output_module_redshift_cluster_port"></a> [module\_redshift\_cluster\_port](#output\_module\_redshift\_cluster\_port) | The Redshift - Cluster Port |
| <a name="output_module_redshift_cluster_preferred_maintenance_window"></a> [module\_redshift\_cluster\_preferred\_maintenance\_window](#output\_module\_redshift\_cluster\_preferred\_maintenance\_window) | The Redshift - Cluster Preferred Maintenance Window |
| <a name="output_module_redshift_cluster_public_key"></a> [module\_redshift\_cluster\_public\_key](#output\_module\_redshift\_cluster\_public\_key) | The Redshift - Cluster Public Key |
| <a name="output_module_redshift_cluster_revision_number"></a> [module\_redshift\_cluster\_revision\_number](#output\_module\_redshift\_cluster\_revision\_number) | The Redshift - Cluster Revision Number |
| <a name="output_module_redshift_cluster_security_groups"></a> [module\_redshift\_cluster\_security\_groups](#output\_module\_redshift\_cluster\_security\_groups) | The Redshift - Cluster Security Groups |
| <a name="output_module_redshift_cluster_subnet_group_name"></a> [module\_redshift\_cluster\_subnet\_group\_name](#output\_module\_redshift\_cluster\_subnet\_group\_name) | The Redshift - Cluster Subnet Group Name |
| <a name="output_module_redshift_cluster_type"></a> [module\_redshift\_cluster\_type](#output\_module\_redshift\_cluster\_type) | The Redshift - Cluster Type |
| <a name="output_module_redshift_cluster_version"></a> [module\_redshift\_cluster\_version](#output\_module\_redshift\_cluster\_version) | The Redshift - Cluster Version |
| <a name="output_module_redshift_cluster_vpc_security_group_ids"></a> [module\_redshift\_cluster\_vpc\_security\_group\_ids](#output\_module\_redshift\_cluster\_vpc\_security\_group\_ids) | The Redshift - Cluster VPC Security Group IDs |
| <a name="output_module_redshift_endpoint_access_address"></a> [module\_redshift\_endpoint\_access\_address](#output\_module\_redshift\_endpoint\_access\_address) | The Redshift - Endpoint Access Address |
| <a name="output_module_redshift_endpoint_access_id"></a> [module\_redshift\_endpoint\_access\_id](#output\_module\_redshift\_endpoint\_access\_id) | The Redshift - Endpoint Access ID |
| <a name="output_module_redshift_endpoint_access_port"></a> [module\_redshift\_endpoint\_access\_port](#output\_module\_redshift\_endpoint\_access\_port) | The Redshift - Endpoint Access Port |
| <a name="output_module_redshift_endpoint_access_vpc_endpoint"></a> [module\_redshift\_endpoint\_access\_vpc\_endpoint](#output\_module\_redshift\_endpoint\_access\_vpc\_endpoint) | The Redshift - Endpoint Access VPC Endpoint |
| <a name="output_module_redshift_parameter_group_arn"></a> [module\_redshift\_parameter\_group\_arn](#output\_module\_redshift\_parameter\_group\_arn) | The Redshift - Parameter Group ARN |
| <a name="output_module_redshift_parameter_group_id"></a> [module\_redshift\_parameter\_group\_id](#output\_module\_redshift\_parameter\_group\_id) | The Redshift - Parameter Group ID |
| <a name="output_module_redshift_scheduled_action_iam_role_arn"></a> [module\_redshift\_scheduled\_action\_iam\_role\_arn](#output\_module\_redshift\_scheduled\_action\_iam\_role\_arn) | The Redshift - Scheduled Action IAM Role ARN |
| <a name="output_module_redshift_scheduled_action_iam_role_name"></a> [module\_redshift\_scheduled\_action\_iam\_role\_name](#output\_module\_redshift\_scheduled\_action\_iam\_role\_name) | The Redshift - Scheduled Action IAM Role Name |
| <a name="output_module_redshift_scheduled_action_iam_role_unique_id"></a> [module\_redshift\_scheduled\_action\_iam\_role\_unique\_id](#output\_module\_redshift\_scheduled\_action\_iam\_role\_unique\_id) | The Redshift - Scheduled Action IAM Role Unique ID |
| <a name="output_module_redshift_scheduled_actions"></a> [module\_redshift\_scheduled\_actions](#output\_module\_redshift\_scheduled\_actions) | The Redshift - Scheduled Actions |
| <a name="output_module_redshift_snapshot_schedule_arn"></a> [module\_redshift\_snapshot\_schedule\_arn](#output\_module\_redshift\_snapshot\_schedule\_arn) | The Redshift - Snapshot Schedule ARN |
| <a name="output_module_redshift_subnet_group_arn"></a> [module\_redshift\_subnet\_group\_arn](#output\_module\_redshift\_subnet\_group\_arn) | The Redshift - Subnet Group ARN |
| <a name="output_module_redshift_subnet_group_id"></a> [module\_redshift\_subnet\_group\_id](#output\_module\_redshift\_subnet\_group\_id) | The Redshift - Subnet Group ID |
| <a name="output_module_redshift_usage_limits"></a> [module\_redshift\_usage\_limits](#output\_module\_redshift\_usage\_limits) | The Redshift - Usage Limits |
| <a name="output_module_s3_logs_s3_bucket_arn"></a> [module\_s3\_logs\_s3\_bucket\_arn](#output\_module\_s3\_logs\_s3\_bucket\_arn) | The S3 Logs - S3 Bucket ARN |
| <a name="output_module_s3_logs_s3_bucket_bucket_domain_name"></a> [module\_s3\_logs\_s3\_bucket\_bucket\_domain\_name](#output\_module\_s3\_logs\_s3\_bucket\_bucket\_domain\_name) | The S3 Logs - S3 Bucket Bucket Domain Name |
| <a name="output_module_s3_logs_s3_bucket_bucket_regional_domain_name"></a> [module\_s3\_logs\_s3\_bucket\_bucket\_regional\_domain\_name](#output\_module\_s3\_logs\_s3\_bucket\_bucket\_regional\_domain\_name) | The S3 Logs - S3 Bucket Bucket Regional Domain Name |
| <a name="output_module_s3_logs_s3_bucket_hosted_zone_id"></a> [module\_s3\_logs\_s3\_bucket\_hosted\_zone\_id](#output\_module\_s3\_logs\_s3\_bucket\_hosted\_zone\_id) | The S3 Logs - S3 Bucket Hosted Zone ID |
| <a name="output_module_s3_logs_s3_bucket_id"></a> [module\_s3\_logs\_s3\_bucket\_id](#output\_module\_s3\_logs\_s3\_bucket\_id) | The S3 Logs - S3 Bucket ID |
| <a name="output_module_s3_logs_s3_bucket_region"></a> [module\_s3\_logs\_s3\_bucket\_region](#output\_module\_s3\_logs\_s3\_bucket\_region) | The S3 Logs - S3 Bucket Region |
| <a name="output_module_s3_logs_s3_bucket_website_domain"></a> [module\_s3\_logs\_s3\_bucket\_website\_domain](#output\_module\_s3\_logs\_s3\_bucket\_website\_domain) | The S3 Logs - S3 Bucket Website Domain |
| <a name="output_module_s3_logs_s3_bucket_website_endpoint"></a> [module\_s3\_logs\_s3\_bucket\_website\_endpoint](#output\_module\_s3\_logs\_s3\_bucket\_website\_endpoint) | The S3 Logs - S3 Bucket Website Endpoint |
| <a name="output_module_vpc_azs"></a> [module\_vpc\_azs](#output\_module\_vpc\_azs) | The VPC - Availability Zones |
| <a name="output_module_vpc_default_network_acl_id"></a> [module\_vpc\_default\_network\_acl\_id](#output\_module\_vpc\_default\_network\_acl\_id) | The VPC - ACL ID |
| <a name="output_module_vpc_default_route_table_id"></a> [module\_vpc\_default\_route\_table\_id](#output\_module\_vpc\_default\_route\_table\_id) | The VPC - Default Route Table ID |
| <a name="output_module_vpc_default_security_group_id"></a> [module\_vpc\_default\_security\_group\_id](#output\_module\_vpc\_default\_security\_group\_id) | The VPC - Default Security Group ID |
| <a name="output_module_vpc_name"></a> [module\_vpc\_name](#output\_module\_vpc\_name) | The VPC - Name |
| <a name="output_module_vpc_private_network_acl_arn"></a> [module\_vpc\_private\_network\_acl\_arn](#output\_module\_vpc\_private\_network\_acl\_arn) | The VPC - Private Network ACL ARN |
| <a name="output_module_vpc_private_network_acl_id"></a> [module\_vpc\_private\_network\_acl\_id](#output\_module\_vpc\_private\_network\_acl\_id) | The VPC - Private Network ACL ID |
| <a name="output_module_vpc_private_route_table_association_ids"></a> [module\_vpc\_private\_route\_table\_association\_ids](#output\_module\_vpc\_private\_route\_table\_association\_ids) | The VPC - Private Route Table Associations IDs |
| <a name="output_module_vpc_private_route_table_ids"></a> [module\_vpc\_private\_route\_table\_ids](#output\_module\_vpc\_private\_route\_table\_ids) | The VPC - Private Route Table IDs |
| <a name="output_module_vpc_private_subnet_arns"></a> [module\_vpc\_private\_subnet\_arns](#output\_module\_vpc\_private\_subnet\_arns) | The VPC - Private Subnet ARNs |
| <a name="output_module_vpc_private_subnets"></a> [module\_vpc\_private\_subnets](#output\_module\_vpc\_private\_subnets) | The VPC - Private Subnets |
| <a name="output_module_vpc_private_subnets_cidr_blocks"></a> [module\_vpc\_private\_subnets\_cidr\_blocks](#output\_module\_vpc\_private\_subnets\_cidr\_blocks) | The VPC - Private Subnets CIDR Blocks |
| <a name="output_module_vpc_redshift_network_acl_arn"></a> [module\_vpc\_redshift\_network\_acl\_arn](#output\_module\_vpc\_redshift\_network\_acl\_arn) | The VPC - Reshift Network ACL ARNs |
| <a name="output_module_vpc_redshift_network_acl_id"></a> [module\_vpc\_redshift\_network\_acl\_id](#output\_module\_vpc\_redshift\_network\_acl\_id) | The VPC - Reshift Network ACL ID |
| <a name="output_module_vpc_redshift_route_table_association_ids"></a> [module\_vpc\_redshift\_route\_table\_association\_ids](#output\_module\_vpc\_redshift\_route\_table\_association\_ids) | The VPC - Reshift Route Table Association IDs |
| <a name="output_module_vpc_redshift_route_table_ids"></a> [module\_vpc\_redshift\_route\_table\_ids](#output\_module\_vpc\_redshift\_route\_table\_ids) | The VPC - Reshift Route Table IDs |
| <a name="output_module_vpc_redshift_subnet_arns"></a> [module\_vpc\_redshift\_subnet\_arns](#output\_module\_vpc\_redshift\_subnet\_arns) | The VPC - Reshift Subnet ARNs |
| <a name="output_module_vpc_redshift_subnet_group"></a> [module\_vpc\_redshift\_subnet\_group](#output\_module\_vpc\_redshift\_subnet\_group) | The VPC - Reshift Subnet Group |
| <a name="output_module_vpc_redshift_subnets"></a> [module\_vpc\_redshift\_subnets](#output\_module\_vpc\_redshift\_subnets) | The VPC - Reshift Subnets |
| <a name="output_module_vpc_redshift_subnets_cidr_blocks"></a> [module\_vpc\_redshift\_subnets\_cidr\_blocks](#output\_module\_vpc\_redshift\_subnets\_cidr\_blocks) | The VPC - Reshift Subnets CIDR Blocks |
| <a name="output_module_vpc_vpc_arn"></a> [module\_vpc\_vpc\_arn](#output\_module\_vpc\_vpc\_arn) | The VPC - VPC ARN |
| <a name="output_module_vpc_vpc_cidr_block"></a> [module\_vpc\_vpc\_cidr\_block](#output\_module\_vpc\_vpc\_cidr\_block) | The VPC - VPC CIDR Block |
| <a name="output_module_vpc_vpc_enable_dns_hostnames"></a> [module\_vpc\_vpc\_enable\_dns\_hostnames](#output\_module\_vpc\_vpc\_enable\_dns\_hostnames) | The VPC - VPC Enable DNS Hostnames |
| <a name="output_module_vpc_vpc_enable_dns_support"></a> [module\_vpc\_vpc\_enable\_dns\_support](#output\_module\_vpc\_vpc\_enable\_dns\_support) | The VPC - VPC Enable DNS Support |
| <a name="output_module_vpc_vpc_flow_log_cloudwatch_iam_role_arn"></a> [module\_vpc\_vpc\_flow\_log\_cloudwatch\_iam\_role\_arn](#output\_module\_vpc\_vpc\_flow\_log\_cloudwatch\_iam\_role\_arn) | The VPC - VPC Flow Log CloudWatch IAM Role ARN |
| <a name="output_module_vpc_vpc_flow_log_destination_arn"></a> [module\_vpc\_vpc\_flow\_log\_destination\_arn](#output\_module\_vpc\_vpc\_flow\_log\_destination\_arn) | The VPC - VPC Flow Log Destination ARN |
| <a name="output_module_vpc_vpc_flow_log_destination_type"></a> [module\_vpc\_vpc\_flow\_log\_destination\_type](#output\_module\_vpc\_vpc\_flow\_log\_destination\_type) | The VPC - VPC Flow Log Destination Type |
| <a name="output_module_vpc_vpc_flow_log_id"></a> [module\_vpc\_vpc\_flow\_log\_id](#output\_module\_vpc\_vpc\_flow\_log\_id) | The VPC - VPC Flow Log ID |
| <a name="output_module_vpc_vpc_id"></a> [module\_vpc\_vpc\_id](#output\_module\_vpc\_vpc\_id) | The VPC - VPC ID |
| <a name="output_module_vpc_vpc_instance_tenancy"></a> [module\_vpc\_vpc\_instance\_tenancy](#output\_module\_vpc\_vpc\_instance\_tenancy) | The VPC - VPC Instance Tenancy |
| <a name="output_module_vpc_vpc_ipv6_association_id"></a> [module\_vpc\_vpc\_ipv6\_association\_id](#output\_module\_vpc\_vpc\_ipv6\_association\_id) | The VPC - VPC IPv6 Association ID |
| <a name="output_module_vpc_vpc_ipv6_cidr_block"></a> [module\_vpc\_vpc\_ipv6\_cidr\_block](#output\_module\_vpc\_vpc\_ipv6\_cidr\_block) | The VPC - VPC IPv6 CIDR Block |
| <a name="output_module_vpc_vpc_main_route_table_id"></a> [module\_vpc\_vpc\_main\_route\_table\_id](#output\_module\_vpc\_vpc\_main\_route\_table\_id) | The VPC - VPC Main Route Table ID |
| <a name="output_module_vpc_vpc_owner_id"></a> [module\_vpc\_vpc\_owner\_id](#output\_module\_vpc\_vpc\_owner\_id) | The VPC - VPC Owner ID |
| <a name="output_redshift_service_account_arn"></a> [redshift\_service\_account\_arn](#output\_redshift\_service\_account\_arn) | The Redshift Service Account - ARN |
| <a name="output_redshift_service_account_id"></a> [redshift\_service\_account\_id](#output\_redshift\_service\_account\_id) | The Redshift Service Account - ID |
| <a name="output_redshift_service_account_region"></a> [redshift\_service\_account\_region](#output\_redshift\_service\_account\_region) | The Redshift Service Account - Region |
| <a name="output_redshift_subnet_group_endpoint_arn"></a> [redshift\_subnet\_group\_endpoint\_arn](#output\_redshift\_subnet\_group\_endpoint\_arn) | The Redshift Subnet Group - ARN |
| <a name="output_redshift_subnet_group_endpoint_description"></a> [redshift\_subnet\_group\_endpoint\_description](#output\_redshift\_subnet\_group\_endpoint\_description) | The Redshift Subnet Group - Description |
| <a name="output_redshift_subnet_group_endpoint_id"></a> [redshift\_subnet\_group\_endpoint\_id](#output\_redshift\_subnet\_group\_endpoint\_id) | The Redshift Subnet Group - ID |
| <a name="output_redshift_subnet_group_endpoint_name"></a> [redshift\_subnet\_group\_endpoint\_name](#output\_redshift\_subnet\_group\_endpoint\_name) | The Redshift Subnet Group - Name |
| <a name="output_redshift_subnet_group_endpoint_subnet_ids"></a> [redshift\_subnet\_group\_endpoint\_subnet\_ids](#output\_redshift\_subnet\_group\_endpoint\_subnet\_ids) | The Redshift Subnet Group - Subnet IDs |

## Additional Information

- The code the Redshift Module uses to auto generate a password will sometimes generate a password with a `@` which is a not allowed symbol in AWS passwords. If this happens destroy the template and start again.
- At times when applying the Terraform files the connection might be cut. If this happens anything in the process of creating will still be created. You can apply again and it should create the remaining resources.

### Examples for the Complex Map Variables 

In the variables.tf file there are 4 variables that when used have a more complex structure to be valid when using the module. 
- parameters
- scheduled_actions
- usage_limits
- authentication_profiles

#### Parameters

With the parameters variable you only have a certain [list](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html) that the Redshift Cluster uses. Here is an example of the `parameter` variable in use.

```
parameters = {
  enable_user_activity_logging = {
    name  = "enable_user_activity_logging",
    value = "true"
  },
  max_concurrency_scaling_clusters = {
    name  = "max_concurrency_scaling_clusters",
    value = "3"
  }
}
```

#### Scheduled Actions

With the scheduled actions variable you are able to [Pause, Resume, and Resize](https://docs.aws.amazon.com/redshift/latest/APIReference/API_CreateScheduledAction.html) the Redshift Cluster on a Schedule. NOTE: You must have the ability to create an IAM Role for this variable to work. Here is an example of the `schedule_action` variable in use.

```
scheduled_actions = {
  pause = {
    name          = "example-pause"
    description   = "Pause cluster every night"
    schedule      = "cron(0 22 * * ? *)"
    pause_cluster = "true"
  }
  resize = {
    name        = "example-resize"
    description = "Resize cluster (demo only)"
    schedule    = "cron(00 13 * * ? *)"
    resize_cluster = {
      node_type       = "ds2.xlarge"
      number_of_nodes = "5"
    }
  }
  resume = {
    name           = "example-resume"
    description    = "Resume cluster every morning"
    schedule       = "cron(0 12 * * ? *)"
    resume_cluster = "true"
  }
}
```

#### Usage Limits

With the usage limits variable you have the ability to [add limits](https://docs.aws.amazon.com/redshift/latest/mgmt/managing-cluster-usage-limits.html) to the Redshift Cluster for Concurrency Scaling, Spectrum and Cross-Region Datasharing. Here is an example of the `usage_limits` variable in use.

```
usage_limits = {
  currency_scaling = {
    feature_type  = "concurrency-scaling"
    limit_type    = "time"
    amount        = "60"
    breach_action = "emit-metric"
  }
  spectrum = {
    feature_type  = "spectrum"
    limit_type    = "data-scanned"
    amount        = "2"
    breach_action = "disable"
    tags = {
      Additional = "CustomUsageLimits"
    }
  }
  cross_region_datasharing = {
    feature_type = "cross-region-datasharing"
    limit_type   = "data-scanned"
    amount       = "4"
    period       = "weekly"
  }
}
```

#### Authentication Profiles

With the authentication profiles variable you can [create](https://docs.aws.amazon.com/redshift/latest/mgmt/connecting-with-authentication-profiles.html) profiles users can connect with as it can store connection options together. Here is an example of the `authentication_profiles` in use.

```
authentication_profiles = {
  example = {
    name = "example"
    content = {
      AllowDBUserOverride = "1"
      Client_ID           = "ExampleClientID"
      App_ID              = "example"
    }
  }
}
```

## Helpful Links

[https://aws.amazon.com/redshift/](https://aws.amazon.com/redshift/)

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)