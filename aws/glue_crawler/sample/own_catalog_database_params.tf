resource "aws_glue_catalog_database" "catalog_database" {
  name = "test-catalog-database"
}

module "aws_glue_crawlers" {
  source = "./aws_glue_crawler_module"

  create_catalog_database      = false
  catalog_database_for_crawler = aws_glue_catalog_database.catalog_database.name

  glue_crawlers = [
    {
      name = "test-module-crawler"
      targets = [
        {
          target = "s3",
          path   = "s3://path/to/data",
        },
      ]
    },
  ]
}