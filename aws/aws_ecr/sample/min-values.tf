module "project_ecr3" {
  create_repository = true
  #source                                 = "../terraform_modules/aws/aws_ecr"
  source                                 = "../../code/terraform_modules/aws/aws_ecr/code"
  location                               = "eu-west-1"
  repository_name                        = "temp-repo3"
  manage_registry_scanning_configuration = true
  #repository_kms_key             = "arn:aws:kms:eu-west-1:834829128384:key/08b33490-0b36-4976-84a1-7a21853e1823"
  tags = {
    "env" = "Non-Prod"
    "Name" = "repo"
  }
  
}
