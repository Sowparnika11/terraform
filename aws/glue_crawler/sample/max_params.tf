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