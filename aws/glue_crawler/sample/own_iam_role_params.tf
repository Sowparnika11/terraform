data "aws_iam_policy" "glue_console_full_access" {
  arn   = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_role" "glue-role" {
  name = "AWSGlueConsoleFullAccess-glue-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = {
    terraform = true
  }
}

resource "aws_iam_role_policy_attachment" "glue-role-policy-attachment" {
  role       = aws_iam_role.glue-role.name
  policy_arn = data.aws_iam_policy.glue_console_full_access.arn
}

module "aws_glue_crawlers" {
  source = "./aws_glue_crawler_module"

  catalog_database_name = "test-catalog-database"

  create_iam_role = false
  role_arn_for_crawler = aws_iam_role.glue-role.arn

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