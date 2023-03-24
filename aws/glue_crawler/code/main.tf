data "aws_iam_policy" "glue_console_full_access" {
  count = var.create_iam_role && var.create_all ? 1 : 0
  arn   = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_role" "this" {
  count = var.create_iam_role && var.create_all ? 1 : 0

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

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.create_iam_role && var.create_all ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = data.aws_iam_policy.glue_console_full_access[0].arn
}

# #################################################################################################

resource "aws_glue_catalog_database" "this" {
  count = var.create_catalog_database && var.create_all ? 1 : 0

  name = var.catalog_database_name

  description = var.catalog_database_description

  catalog_id   = var.catalog_database_catalog_id
  location_uri = var.catalog_database_location_uri
  parameters   = var.catalog_database_parameters

  target_database {
    catalog_id    = var.td_catalog_id
    database_name = var.td_database_name
  }

  create_table_default_permission {
    permissions = length(var.ctdfp_permissions) > 0 ? var.ctdfp_permissions : ["ALL"]

    principal {
      data_lake_principal_identifier = length(var.ctdfp_data_lake_principal_identifier) > 0 ? var.ctdfp_data_lake_principal_identifier : "IAM_ALLOWED_PRINCIPALS"
    }
  }
}

# #################################################################################################

resource "aws_glue_crawler" "this" {
  count = var.create_crawler && var.create_all ? length(var.glue_crawlers) : 0

  name          = lookup(var.glue_crawlers[count.index], "name", null)
  database_name = var.create_catalog_database ? aws_glue_catalog_database.this[0].name : var.catalog_database_for_crawler
  role          = var.create_iam_role ? aws_iam_role.this[0].arn : var.role_arn_for_crawler

  description = lookup(var.glue_crawlers[count.index], "description", null)

  classifiers   = lookup(var.glue_crawlers[count.index], "classifiers", null)
  configuration = lookup(var.glue_crawlers[count.index], "configuration", null) != null ? jsonencode(var.glue_crawlers[count.index].configuration) : null
  schedule      = lookup(var.glue_crawlers[count.index], "schedule", null)

  security_configuration = lookup(var.glue_crawlers[count.index], "security_configuration", null)
  table_prefix           = lookup(var.glue_crawlers[count.index], "table_prefix", null)

  # ###############################################################################################

  dynamic "dynamodb_target" {
    for_each = [
      for target in var.glue_crawlers[count.index].targets : target
      if target["target"] == "dynamodb"
    ]

    content {
      path      = lookup(dynamodb_target.value, "path", null)
      scan_all  = lookup(dynamodb_target.value, "scan_all", null)
      scan_rate = lookup(dynamodb_target.value, "scan_rate", null)
    }
  }

  dynamic "jdbc_target" {
    for_each = [
      for target in var.glue_crawlers[count.index].targets : target
      if target["target"] == "jdbc"
    ]

    content {
      connection_name            = lookup(jdbc_target.value, "connection_name", null)
      path                       = lookup(jdbc_target.value, "path", null)
      exclusions                 = lookup(jdbc_target.value, "exclusions", null)
      enable_additional_metadata = lookup(jdbc_target.value, "enable_additional_metadata", null)
    }
  }

  dynamic "s3_target" {
    for_each = [
      for target in var.glue_crawlers[count.index].targets : target
      if target["target"] == "s3"
    ]

    content {
      path                = lookup(s3_target.value, "path", null)
      connection_name     = lookup(s3_target.value, "connection_name", null)
      exclusions          = lookup(s3_target.value, "exclusions", null)
      sample_size         = lookup(s3_target.value, "sample_size", null)
      event_queue_arn     = lookup(s3_target.value, "event_queue_arn", null)
      dlq_event_queue_arn = lookup(s3_target.value, "dlq_event_queue_arn", null)
    }
  }

  dynamic "catalog_target" {
    for_each = [
      for target in var.glue_crawlers[count.index].targets : target
      if target["target"] == "catalog"
    ]

    content {
      connection_name     = lookup(catalog_target.value, "connection_name", null)
      database_name       = lookup(catalog_target.value, "database_name", null)
      tables              = lookup(catalog_target.value, "tables", null)
      event_queue_arn     = lookup(catalog_target.value, "event_queue_arn", null)
      dlq_event_queue_arn = lookup(catalog_target.value, "dlq_event_queue_arn", null)
    }
  }

  dynamic "mongodb_target" {
    for_each = [
      for target in var.glue_crawlers[count.index].targets : target
      if target["target"] == "mongodb"
    ]

    content {
      connection_name = lookup(mongodb_target.value, "connection_name", null)
      path            = lookup(mongodb_target.value, "path", null)
      scan_all        = lookup(mongodb_target.value, "scan_all", null)
    }
  }

  dynamic "delta_target" {
    for_each = [
      for target in var.glue_crawlers[count.index].targets : target
      if target["target"] == "delta"
    ]

    content {
      connection_name = lookup(delta_target.value, "connection_name", null)
      delta_tables    = lookup(delta_target.value, "delta_tables", null)
      write_manifest  = lookup(delta_target.value, "write_manifest", null)
    }
  }

  # ###############################################################################################

  dynamic "schema_change_policy" {
    for_each = lookup(var.glue_crawlers[count.index], "schema_change_policy", null) != null ? [1] : []

    content {
      delete_behavior = lookup(var.glue_crawlers[count.index].schema_change_policy, "delete_behavior", null)
      update_behavior = lookup(var.glue_crawlers[count.index].schema_change_policy, "update_behavior", null)
    }
  }

  dynamic "lake_formation_configuration" {
    for_each = lookup(var.glue_crawlers[count.index], "lake_formation_configuration", null) != null ? [1] : []

    content {
      account_id                     = lookup(var.glue_crawlers[count.index].lake_formation_configuration, "account_id", null)
      use_lake_formation_credentials = lookup(var.glue_crawlers[count.index].lake_formation_configuration, "use_lake_formation_credentials", null)
    }
  }

  dynamic "lineage_configuration" {
    for_each = lookup(var.glue_crawlers[count.index], "lineage_configuration", null) != null ? [1] : []

    content {
      crawler_lineage_settings = lookup(var.glue_crawlers[count.index].lineage_configuration, "crawler_lineage_settings", null)
    }
  }

  dynamic "recrawl_policy" {
    for_each = lookup(var.glue_crawlers[count.index], "recrawl_policy", null) != null ? [1] : []

    content {
      recrawl_behavior = lookup(var.glue_crawlers[count.index].recrawl_policy, "recrawl_behavior", null)
    }
  }

  tags = var.tags
}