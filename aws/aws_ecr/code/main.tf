resource "aws_ecr_repository" "aws_ecr_repository" {
  count                = var.create_repository ? 1 : 0
  name                 = var.repository_name
  image_tag_mutability = var.repository_image_tag_mutability

  encryption_configuration {
    encryption_type = "KMS"
    kms_key = var.repository_kms_key
  }

  image_scanning_configuration {
    scan_on_push = var.repository_image_scan_on_push
  }
  force_delete = var.repository_force_delete
  
  tags = merge(
    var.tags,
    { Name = var.repository_name }
  )

}

resource "aws_ecr_registry_scanning_configuration" "aws_ecr_registry_scanning_configuration" {
  count = var.create_repository && var.manage_registry_scanning_configuration ? 1 : 0

  scan_type = var.registry_scan_type

  dynamic "rule" {
    for_each = var.registry_scan_rules

    content {
      scan_frequency = rule.value.scan_frequency

      repository_filter {
        filter      = rule.value.filter
        filter_type = try(rule.value.filter_type, "WILDCARD")
      }
    }
  }
}

resource "aws_ecr_registry_policy" "aws_ecr_registry_policy" {
  count  = var.create_repository && var.create_registry_policy ? 1 : 0
  policy = var.registry_policy
}
resource "aws_ecr_lifecycle_policy" "aws_ecr_lifecycle_policy" {
  count = var.create_repository && var.create_lifecycle_policy ? 1 : 0

  repository = aws_ecr_repository.aws_ecr_repository[0].name
  policy     = var.repository_lifecycle_policy
}

