module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name             = "redshift-vpc"
  cidr             = "10.0.0.0/16"
  azs              = ["us-east-1a", "us-east-1b"]
  private_subnets  = ["10.0.0.0/19", "10.0.32.0/19"]
  redshift_subnets = ["10.0.128.0/20", "10.0.144.0/20"]

  create_redshift_subnet_group = false

  tags = {
    terraform = true
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/redshift"

  name   = "redshift-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules       = ["redshift-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  egress_rules        = ["all-all"]

  tags = {
    terraform = true
  }
}

module "redshift_cluster" {
  source = "./redshift_module"

  name = "example-rc"

  master_user_name      = "redshift_admin"
  node_type             = "ra3.xlplus"
  number_of_nodes       = 1
  database_name         = "example_database"
  redshift_cluster_port = 8200

  enable_availability_zone_relocation = true
  enable_endpoint_access              = true

  use_own_vpc                     = true
  created_vpc_redshift_subnet_ids = module.vpc.redshift_subnets
  created_vpc_private_subnet_ids  = module.vpc.private_subnets
  created_vpc_security_group_id   = module.security_group.security_group_id

  tags = {
    terraform = true
  }
}