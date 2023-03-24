resource "aws_kms_key" "kms_key" {
  description             = "Managed Key for Encrypting a Redshift Cluster"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    terraform = true
  }
}

module "redshift_cluster" {
  source = "./redshift_module"

  name = "example-rc"

  availability_zones    = ["us-east-1a", "us-east-1b"]
  vpc_cidr              = "10.0.0.0/16"
  private_subnet_cidrs  = ["10.0.0.0/19", "10.0.32.0/19"]
  redshift_subnet_cidrs = ["10.0.128.0/20", "10.0.144.0/20"]

  master_user_name      = "redshift_admin"
  node_type             = "dc2.large"
  number_of_nodes       = 1
  database_name         = "example_database"
  redshift_cluster_port = 8200

  enable_encryption_at_rest = true
  use_own_kms_key           = true
  created_kms_key_arn       = aws_kms_key.kms_key.arn

  tags = {
    terraform = true
  }
}