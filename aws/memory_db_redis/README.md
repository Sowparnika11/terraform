AWS MemoryDB for Redis Terraform module
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)
MemoryDB is compatible with Redis, a popular open source data store, enabling you to quickly build applications using the same flexible and friendly Redis data structures, APIs, and commands that they already use today. With MemoryDB, all of your data is stored in memory, which enables you to achieve microsecond read and single-digit millisecond write latency and high throughput. MemoryDB also stores data durably across multiple Availability Zones (AZs) using a Multi-AZ transactional log to enable fast failover, database recovery, and node restarts.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Examples
- With all parameters
  ```hcl 
  module "memory_db" {
  source = "./code"

  # Cluster
  location = "eu-west-2"
  name        = "example"
  description = "Example MemoryDB cluster"

  engine_version             = "6.2"
  auto_minor_version_upgrade = true
  node_type                  = "db.t4g.small"
  num_shards                 = 2
  num_replicas_per_shard     = 2

  tls_enabled              = true
  security_group_ids       = ["sg-02ce3f91aaa95aa8e"]
  maintenance_window       = "sun:23:00-mon:01:30"

  # Users
  users = {
    admin = {
      user_name     = "admin-user"
      access_string = "on ~* &* +@all"
      passwords     = ["12345678910123456"]
      tags          = { User = "admin" }
    }
    readonly = {
      user_name     = "readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = ["12345678910123456"]
      tags          = { User = "readonly" }
    }
  }
  # # ACL
  acl_name = "example-acl"
  acl_tags = { Acl = "custom" }

  # Parameter group
  parameter_group_name        = "example-param-group"
  parameter_group_description = "Example MemoryDB parameter group"
  parameter_group_family      = "memorydb_redis6"
  parameter_group_parameters = [
    {
      name  = "activedefrag"
      value = "yes"
    }
  ]
  parameter_group_tags = {
    ParameterGroup = "custom"
  }

  # Subnet group
  subnet_group_name        = "example-subnet-group"
  subnet_group_description = "Example MemoryDB subnet group"
  subnet_ids               = ["subnet-0ab3f8a4eaf909c29", "subnet-0c986770bd899279e"]
  subnet_group_tags = {
    SubnetGroup = "custom"
  }

  tags = {
    Name = "test-sample"
    Environment = "dev"
  }
  }

   ```

## Requirements

| Name  | Version |
| ----- | ------- |
| Terraform | >= 0.13 |
| Aws  | >= 4.52.0 |

## Providers

| Name  | Version |
| ----- | ------- |
| Aws  | >= 4.52.0 |

## Resource

| Name | Type |
|----- | ---- |
| aws_memorydb_cluster.sample-cluster | Resource |
| aws_memorydb_user.db_user | Resource |
| aws_memorydb_acl.db_acl| Resource |
| aws_memorydb_parameter_group.db_param_group | Resource|
| aws_memorydb_subnet_group.subnet_group| Resource |

## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| name|Cluster name - also default name used on all resources if more specific resource names are not provided| `string` | "" | No|
|create| Determines whether resources will be created - affects all resources| `bool`| True | No|
| acl_name | The name of the Access Control List to associate with the cluster | `string` | Null | Yes |
| acl_tags | Additional tags for the ACL created | `map(string)` | {} | No|
| acl_use_name_prefix | Determines whether acl_name is used as a prefix | `bool` | False | No|
| acl_user_names | List of externally created user names to associate with the ACL | `list(string)` | [] | No|
| auto_minor_version_upgrade| Determines whether to create ACL specified | `bool` | Null | No|
| create_acl | Configuration block for the versioning parameters to decide whether versioning should be enabled or not|  `bool` | True | No|
| create_parameter_group | Determines whether to create parameter group specified | `bool` | True | No|
| create_subnet_group | Determines whether to create subnet group specified | `bool` | True | No|
| create_users | Determines whether to create users specified | `bool` | True | No|
| description | Description for the cluster. Defaults to Managed by Terraform | `string` | Null | No|
| engine_version | Version number of the Redis engine to be used for the cluster. Downgrades are not supported | `number` | 7 | No|
| final_snapshot_name | Name of the final cluster snapshot to be created when this resource is deleted. If omitted, no final snapshot will be made | `string` | Null | No|
| kms_key_arn | ARN of the KMS key used to encrypt the cluster at rest | `string` | Null | No|
| maintenance_window | Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi | `string` | Null | No|
| node_type | The compute and memory capacity of the nodes in the cluster. See AWS documentation on supported node types as well as vertical scaling | `string` | "" | Yes|
| num_replicas_per_shard  | 	The number of replicas to apply to each shard, up to a maximum of 5. Defaults to 1 (i.e. 2 nodes per shard)| `number` | Null | No|
| num_shards | The number of shards in the cluster. Defaults to 1 |  `number` | Null | No|
| parameter_group_description | Description for the parameter group. Defaults to Managed by Terraform | `string` | Null | No|
| parameter_group_family | The engine version that the parameter group can be used with | `string` | Null | No|
| parameter_group_name | Name of parameter group to be created if create_parameter_group is true, otherwise its the name of an existing parameter group to use if create_parameter_group is false | `string` | Null | No|
| parameter_group_parameters | A list of parameter maps to apply | `list(map(string))	` | [] | No|
| port | The port number on which each of the nodes accepts connections. Defaults to 6379 | `number` | Null | No|
| security_group_ids | Set of VPC Security Group ID-s to associate with this cluster | `list(string)` |Null | No|
| snapshot_arns | List of ARN-s that uniquely identify RDB snapshot files stored in S3. The snapshot files will be used to populate the new cluster |`list(string)` |Null | No|
| snapshot_name | The name of a snapshot from which to restore data into the new cluster |`string` | Null | No|
| snapshot_retention_limit | The number of days for which MemoryDB retains automatic snapshots before deleting them. When set to 0, automatic backups are disabled. Defaults to 0 |`number` | Null | No|
| snapshot_window | The daily time range (in UTC) during which MemoryDB begins taking a daily snapshot of your shard. Example: 05:00-09:00| `string	` | Null | No|
| subnet_group_description | 	Description for the subnet group. Defaults to Managed by Terraform | `string` | Null | No|
| subnet_group_name | Name of subnet group to be created if create_subnet_group is true, otherwise its the name of an existing subnet group to use if create_subnet_group is false |`string` | Null | No|
| subnet_group_tags | Additional tags for the subnet group created |`map(string)` | {} | No|
| subnet_group_use_name_prefix |Determines whether subnet_group_name is used as a prefix |`bool` | False | No|
| subnet_ids | Set of VPC Subnet ID-s for the subnet group. At least one subnet must be provided |`list(string)` | [] | No|
| tags | A map of tags to use on all resources |`map(string)` | {} | No|
| tls_enabled | A flag to enable in-transit encryption on the cluster. When set to false, the acl_name must be open-access. Defaults to true |`bool` | Null | No|
| use_name_prefix | Determines whether name is used as a prefix for the cluster |`bool` | False | No|
| users | A map of user definitions (maps) to be created |`map(any)` | {} | No|



## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)