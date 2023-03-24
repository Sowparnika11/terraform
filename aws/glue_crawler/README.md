# A Module for Creating AWS Glue Crawlers

A Module to create a [AWS Glue Catalog Database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) and its [AWS Glue Crawlers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler). In this module you can create a single AWS Glue Catalog Database, that contains multiple AWS Glue Crawlers. With each Crawler able to have multiple targets. It uses the IAM Policy 'AWSGlueConsoleFullAccess' for the Crawler's IAM Role.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Examples

- An example with Minimum Parameters.

```
module "aws_glue_catalog_database" {
  source = "./aws_glue_crawler_module"

  catalog_database_name = "test-glue-module"
  glue_crawlers         = [
    {
      name = "test-module-crawler"
      targets = [
        {
          target          = "s3",
          path            = "s3://aws-glue-target/data/",
        },
      ]
    },
  ]
}
```

- An example with Maximum Parameters. It creates 2 crawlers, the former having 7 target connections to the different targets.

```
module "aws_glue_crawlers" {
  source = "./aws_glue_crawler_module"

  create_all              = true
  create_catalog_database = true
  create_crawler          = true
  create_iam_role         = true

  catalog_database_for_crawler = ""
  role_arn_for_crawler         = ""

  catalog_database_name         = "test-glue-module"
  catalog_database_description  = "A example catalog database"
  catalog_database_catalog_id   = "123456789012"
  catalog_database_location_uri = "hdfs://host:port/file"
  catalog_database_parameters   = {}

  td_catalog_id    = "target_database_id"
  td_database_name = "target_database"

  ctdfp_permissions                    = "ALL"
  ctdfp_data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"

  glue_crawlers = [
    {
      name        = "test-multiple-database-crawler",
      description = "Testing the a glue crawler template",
      classifiers = ["example-classifier"],
      configuration = {
        Grouping = {
          TableGroupingPolicy = "CombineCompatibleSchemas"
        }
        CrawlerOutput = {
          Partitions = {
            AddOrUpdateBehavior = "InheritFromTable"
          }
        }
        Version = 1
      },
      schedule               = "cron(0 1 * * ? *)",
      security_configuration = "example-security-configuration",
      table_prefix           = "example-",
      targets = [
        {
          target              = "s3"
          path                = "s3//:example//example-1",
          connection_name     = "example-testing-1",
          exclusions          = ["*.csv", "foo.?"],
          sample_size         = 1,
          event_queue_arn     = "arn:aws:sqs:::aws-glue-example",
          dlq_event_queue_arn = "arn:aws:sqs:::aws-glue-example-dl",
        },
        {
          target = "s3",
          path   = "s3//:example//example-2",
        },
        {
          target    = "dynamodb",
          path      = "table_name",
          scan_all  = true,
          scan_rate = 1,
        },
        {
          target                     = "jdbc",
          path                       = "jdbc:redshift://example-rc.us-east-1.redshift.amazonaws.com:8200/example_database",
          exclusions                 = ["*.csv", "foo.?"],
          enable_additional_metadata = [],
        },
        {
          target              = "catalog",
          connection_name     = "example-connection",
          database_name       = "example-database",
          tables              = ["table-1", "table-2"],
          event_queue_arn     = "arn:aws:sqs:::aws-glue-example",
          dlq_event_queue_arn = "arn:aws:sqs:::aws-glue-example-dead-letter",
        },
        {
          target          = "mongodb"
          connection_name = "example-connection",
          path            = "mongodb://<sample-user>:<password>@sample-cluster.node.us-east-1.docdb.amazonaws.com:27017",
          scan_all        = true,
        },
        {
          target          = "delta"
          connection_name = "example-connection"
          delta_tables    = ["s3//:path-to//delta-table-1", "s3//:path-to//delta-table-2"]
          write_manifest  = true
        }
      ],
      schema_change_policy = {
        delete_behavior = "LOG",
        update_behavior = "LOG",
      },
      lake_formation_configuration = {
        account_id                     = "<aws_account_id>",
        use_lake_formation_credentials = false,
      },
      lineage_configuration = {
        crawler_lineage_settings = "ENABLE",
      },
      recrawl_policy = {
        recrawl_behavior = "CRAWL_EVERYTHING",
      },
    },
    {
      name = "test-s3-crawler",
      targets = [
        {
          target = "s3",
          path   = "s3//:example//example-3",
        }
      ]
    },
  ]

  tags = {
    terraform = true
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_glue_catalog_database.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_glue_crawler.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.glue_console_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| <a name="input_catalog_database_catalog_id"></a> [catalog\_database\_catalog\_id](#input\_catalog\_database\_catalog\_id) | (Optional) ID of the Glue Catalog to create the database in. If omitted this defaults to the AWS Account ID. | `string` | `""` |
| <a name="input_catalog_database_description"></a> [catalog\_database\_description](#input\_catalog\_database\_description) | (Optional) The description of the Catalog Database. | `string` | `""` |
| <a name="input_catalog_database_for_crawler"></a> [catalog\_database\_for\_crawler](#input\_catalog\_database\_for\_crawler) | (Optional) Name of the Catalog Database if you did not create one using the module. Needs create\_catalog\_database variable to be false. | `string` | `""` |
| <a name="input_catalog_database_location_uri"></a> [catalog\_database\_location\_uri](#input\_catalog\_database\_location\_uri) | (Optional) Location of the database (for example, an HDFS path). | `string` | `""` |
| <a name="input_catalog_database_name"></a> [catalog\_database\_name](#input\_catalog\_database\_name) | (Required) Name to be used on the Catalog Database. | `string` | `""` |
| <a name="input_catalog_database_parameters"></a> [catalog\_database\_parameters](#input\_catalog\_database\_parameters) | (Optional) List of key-value pairs that define parameters and properties of the database. | `map(any)` | `{}` |
| <a name="input_create_all"></a> [create\_all](#input\_create\_all) | Switch to turn the module on or off. | `bool` | `true` |
| <a name="input_create_catalog_database"></a> [create\_catalog\_database](#input\_create\_catalog\_database) | Controls if a Catalog Database should be Created. | `bool` | `true` |
| <a name="input_create_crawler"></a> [create\_crawler](#input\_create\_crawler) | Controls if the Crawler should be Created. | `bool` | `true` |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Controls if an IAM Role should be Created. | `bool` | `true` |
| <a name="input_ctdfp_data_lake_principal_identifier"></a> [ctdfp\_data\_lake\_principal\_identifier](#input\_ctdfp\_data\_lake\_principal\_identifier) | (Optional) An identifier for the Lake Formation principal. | `string` | `""` |
| <a name="input_ctdfp_permissions"></a> [ctdfp\_permissions](#input\_ctdfp\_permissions) | (Optional) The permissions that are granted to the principal. | `list(any)` | `[]` |
| <a name="input_glue_crawlers"></a> [glue\_crawlers](#input\_glue\_crawlers) | (Required, if you want to use the Glue Crawlers) List of maps to create mulitple Crawlers for a single Catalog Database | `any` | `[]` |
| <a name="input_role_arn_for_crawler"></a> [role\_arn\_for\_crawler](#input\_role\_arn\_for\_crawler) | (Optional) ARN of IAM Role if you did not create one using the module. Needs create\_iam\_role variable to be false. | `string` | `""` |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to use on all the resources | `any` | `{}` |
| <a name="input_td_catalog_id"></a> [td\_catalog\_id](#input\_td\_catalog\_id) | (Required, if you want to use the target\_database feature) ID of the Data Catalog in which the database resides. | `string` | `""` |
| <a name="input_td_database_name"></a> [td\_database\_name](#input\_td\_database\_name) | (Required, if you want to use the target\_database feature) Name of the catalog database. | `string` | `""` |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_database_arn"></a> [catalog\_database\_arn](#output\_catalog\_database\_arn) | The Catalog Database - ARN |
| <a name="output_catalog_database_catalog_id"></a> [catalog\_database\_catalog\_id](#output\_catalog\_database\_catalog\_id) | The Catalog Database - Catalog ID |
| <a name="output_catalog_database_create_table_default_permission"></a> [catalog\_database\_create\_table\_default\_permission](#output\_catalog\_database\_create\_table\_default\_permission) | The Catalog Database - Create Table Default Permission |
| <a name="output_catalog_database_description"></a> [catalog\_database\_description](#output\_catalog\_database\_description) | The Catalog Database - Description |
| <a name="output_catalog_database_id"></a> [catalog\_database\_id](#output\_catalog\_database\_id) | The Catalog Database - ID |
| <a name="output_catalog_database_location_uri"></a> [catalog\_database\_location\_uri](#output\_catalog\_database\_location\_uri) | The Catalog Database - Location URI |
| <a name="output_catalog_database_name"></a> [catalog\_database\_name](#output\_catalog\_database\_name) | The Catalog Database - Name |
| <a name="output_catalog_database_parameters"></a> [catalog\_database\_parameters](#output\_catalog\_database\_parameters) | The Catalog Database - Parameters |
| <a name="output_catalog_database_target_database"></a> [catalog\_database\_target\_database](#output\_catalog\_database\_target\_database) | The Catalog Database - Target Database |
| <a name="output_crawler_arn"></a> [crawler\_arn](#output\_crawler\_arn) | The Crawler - ARN |
| <a name="output_crawler_classifiers"></a> [crawler\_classifiers](#output\_crawler\_classifiers) | The Crawler - Classifiers |
| <a name="output_crawler_configuration"></a> [crawler\_configuration](#output\_crawler\_configuration) | The Crawler - Configuration |
| <a name="output_crawler_database_name"></a> [crawler\_database\_name](#output\_crawler\_database\_name) | The Crawler - Name |
| <a name="output_crawler_description"></a> [crawler\_description](#output\_crawler\_description) | The Crawler - Description |
| <a name="output_crawler_id"></a> [crawler\_id](#output\_crawler\_id) | The Crawler - ID |
| <a name="output_crawler_name"></a> [crawler\_name](#output\_crawler\_name) | The Crawler - Name |
| <a name="output_crawler_role"></a> [crawler\_role](#output\_crawler\_role) | The Crawler - Role |
| <a name="output_crawler_schedule"></a> [crawler\_schedule](#output\_crawler\_schedule) | The Crawler - Schedule |
| <a name="output_crawler_security_configuration"></a> [crawler\_security\_configuration](#output\_crawler\_security\_configuration) | The Crawler - Security Configuration |
| <a name="output_crawler_table_prefix"></a> [crawler\_table\_prefix](#output\_crawler\_table\_prefix) | The Crawler - Table Prefix |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The IAM Policy - ARN |
| <a name="output_iam_policy_description"></a> [iam\_policy\_description](#output\_iam\_policy\_description) | The IAM Policy - Description |
| <a name="output_iam_policy_id"></a> [iam\_policy\_id](#output\_iam\_policy\_id) | The IAM Policy - ID |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | The IAM Policy - Name |
| <a name="output_iam_policy_path"></a> [iam\_policy\_path](#output\_iam\_policy\_path) | The IAM Policy - Path |
| <a name="output_iam_policy_path_prefix"></a> [iam\_policy\_path\_prefix](#output\_iam\_policy\_path\_prefix) | The IAM Policy - Path Prefix |
| <a name="output_iam_policy_policy"></a> [iam\_policy\_policy](#output\_iam\_policy\_policy) | The IAM Policy - Policy |
| <a name="output_iam_policy_policy_id"></a> [iam\_policy\_policy\_id](#output\_iam\_policy\_policy\_id) | The IAM Policy - Policy ID |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The IAM Role - ARN |
| <a name="output_iam_role_assume_role_policy"></a> [iam\_role\_assume\_role\_policy](#output\_iam\_role\_assume\_role\_policy) | The IAM Role - Assume Role Policy |
| <a name="output_iam_role_create_date"></a> [iam\_role\_create\_date](#output\_iam\_role\_create\_date) | The IAM Role - Create Date |
| <a name="output_iam_role_description"></a> [iam\_role\_description](#output\_iam\_role\_description) | The IAM Role - Description |
| <a name="output_iam_role_force_detach_policies"></a> [iam\_role\_force\_detach\_policies](#output\_iam\_role\_force\_detach\_policies) | The IAM Role - Detach Policies |
| <a name="output_iam_role_id"></a> [iam\_role\_id](#output\_iam\_role\_id) | The IAM Role - ID |
| <a name="output_iam_role_managed_policy_arns"></a> [iam\_role\_managed\_policy\_arns](#output\_iam\_role\_managed\_policy\_arns) | The IAM Role - Policy ARNs |
| <a name="output_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#output\_iam\_role\_max\_session\_duration) | The IAM Role - Session Duration |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The IAM Role - Name |
| <a name="output_iam_role_name_prefix"></a> [iam\_role\_name\_prefix](#output\_iam\_role\_name\_prefix) | The IAM Role - Name Prefix |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | The IAM Role - Path |
| <a name="output_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#output\_iam\_role\_permissions\_boundary) | The IAM Role - Permissions Boundary |
| <a name="output_iam_role_policy_attachment_id"></a> [iam\_role\_policy\_attachment\_id](#output\_iam\_role\_policy\_attachment\_id) | The IAM Role Policy Attachment - ID |
| <a name="output_iam_role_policy_attachment_policy_arn"></a> [iam\_role\_policy\_attachment\_policy\_arn](#output\_iam\_role\_policy\_attachment\_policy\_arn) | The IAM Role Policy Attachment - ARN |
| <a name="output_iam_role_policy_attachment_role"></a> [iam\_role\_policy\_attachment\_role](#output\_iam\_role\_policy\_attachment\_role) | The IAM Role Policy Attachment - Role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | The IAM Role - Unique ID |

## Additional Information

For the Glue Crawlers you can create [Glue Classifiers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_classifier) and [Glue Security Configurations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_security_configuration) outside the module to use.

## Helpful Links

[docs.aws.amazon.com/glue/latest/dg/catalog-and-crawler.html](https://docs.aws.amazon.com/glue/latest/dg/catalog-and-crawler.html)

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)