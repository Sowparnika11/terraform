module "project_ecr3" {
  create_repository = true
  source                                 = "../terraform_modules/aws/aws_ecr"
  location                               = "eu-west-1"
  repository_name                        = "temp-repo4"
  manage_registry_scanning_configuration = true
  registry_scan_type                     = "ENHANCED"
  #repository_kms_key             = "arn:aws:kms:eu-west-1:834829128384:key/08b33490-0b36-4976-84a1-7a21853e1823"
  tags = {
    "env" = "Non-Prod"
    "Name" = "repo"
  }
  
  registry_scan_rules = [
    {
      scan_frequency = "SCAN_ON_PUSH"
      filter         = "*"
      filter_type    = "WILDCARD"
      }, {
      scan_frequency = "CONTINUOUS_SCAN"
      filter         = "example"
      filter_type    = "WILDCARD"
    }
  ]

  create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

}
