module "memory_db" {
  source = "./code"

  # Cluster
  location = "eu-west-2"
  name        = "example"
  description = "Example MemoryDB cluster"

  engine_version             = "6.2"
  auto_minor_version_upgrade = true
  node_type                  = "db.t4g.small"
  num_shards                 = 2
  num_replicas_per_shard     = 2

  tls_enabled              = true
  security_group_ids       = ["sg-02ce3f91aaa95aa8e"]
  maintenance_window       = "sun:23:00-mon:01:30"
  # snapshot_retention_limit = 7
  # snapshot_window          = "05:00-09:00"

  # Users
  users = {
    admin = {
      user_name     = "admin-user"
      access_string = "on ~* &* +@all"
      passwords     = ["12345678910123456"]
      tags          = { User = "admin" }
    }
    readonly = {
      user_name     = "readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = ["12345678910123456"]
      tags          = { User = "readonly" }
    }
  }
  # # ACL
  acl_name = "example-acl"
  acl_tags = { Acl = "custom" }

  # Parameter group
  parameter_group_name        = "example-param-group"
  parameter_group_description = "Example MemoryDB parameter group"
  parameter_group_family      = "memorydb_redis6"
  parameter_group_parameters = [
    {
      name  = "activedefrag"
      value = "yes"
    }
  ]
  parameter_group_tags = {
    ParameterGroup = "custom"
  }

  # Subnet group
  subnet_group_name        = "example-subnet-group"
  subnet_group_description = "Example MemoryDB subnet group"
  subnet_ids               = ["subnet-0ab3f8a4eaf909c29", "subnet-0c986770bd899279e"]
  subnet_group_tags = {
    SubnetGroup = "custom"
  }

  tags = {
    Name = "test-sample"
    Environment = "dev"
  }
}