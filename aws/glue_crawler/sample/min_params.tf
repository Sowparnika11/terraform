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