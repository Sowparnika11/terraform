module "redshift_cluster" {
  source = "./redshift_module"

  create_all = true
  name       = "test-rc"

  use_own_kms_key     = false
  created_kms_key_arn = ""

  use_own_s3_log      = false
  created_s3_log_name = ""

  use_own_vpc                     = false
  created_vpc_private_subnet_ids  = []
  created_vpc_redshift_subnet_ids = []
  created_vpc_security_group_id   = ""

  enable_enhanced_vpc_routing = true
  availability_zones          = ["us-east-1a", "us-east-1b"]
  vpc_cidr                    = "10.0.0.0/16"
  private_subnet_cidrs        = ["10.0.0.0/19", "10.0.32.0/19"]
  redshift_subnet_cidrs       = ["10.0.128.0/20", "10.0.144.0/20"]

  enable_logging_to_s3                                 = true
  s3_logs_enable_attach_deny_insecure_transport_policy = true
  s3_logs_force_destroy                                = true
  s3_logs_block_public_acls                            = true
  s3_logs_block_public_policy                          = true
  s3_logs_ignore_public_acls                           = true
  s3_logs_restrict_public_buckets                      = true

  enable_encryption_at_rest   = true
  key_deletion_window_in_days = 14
  enable_key_rotation         = true

  master_user_name       = "redshift_example_admin"
  enable_random_password = true
  master_user_password   = ""

  node_type       = "dc2.large"
  number_of_nodes = 1

  database_name         = "example_database"
  maintenance_window    = "sat:05:00-sat:05:30"
  redshift_cluster_port = 8200

  enable_availability_zone_relocation = false
  enable_endpoint_access              = false

  allow_version_upgrade             = true
  make_redshift_publicly_accessible = false

  enable_snapshot_schedule        = true
  snapshot_schedule_definition    = ["rate(12 hours)"]
  snapshot_schedule_force_destroy = true

  parameters = {
    enable_user_activity_logging = {
      name  = "enable_user_activity_logging",
      value = "true"
    },
    max_concurrency_scaling_clusters = {
      name  = "max_concurrency_scaling_clusters",
      value = "3"
    }
  }

  scheduled_actions = {
    pause = {
      name          = "example-pause"
      description   = "Pause Cluster Every Night"
      schedule      = "cron(0 22 * * ? *)"
      pause_cluster = "true"
    }
    resize = {
      name        = "example-resize"
      description = "Resize Cluster (Demo Only)"
      schedule    = "cron(00 13 * * ? *)"
      resize_cluster = {
        node_type       = "ds2.xlarge"
        number_of_nodes = "5"
      }
    }
    resume = {
      name           = "example-resume"
      description    = "Resume Cluster Every Morning"
      schedule       = "cron(0 12 * * ? *)"
      resume_cluster = "true"
    }
  }

  usage_limits = {
    currency_scaling = {
      feature_type  = "concurrency-scaling"
      limit_type    = "time"
      amount        = "60"
      breach_action = "emit-metric"
    }
    spectrum = {
      feature_type  = "spectrum"
      limit_type    = "data-scanned"
      amount        = "2"
      breach_action = "disable"
      tags = {
        Additional = "CustomUsageLimits"
      }
    }
    cross_region_datasharing = {
      feature_type = "cross-region-datasharing"
      limit_type   = "data-scanned"
      amount       = "4"
      period       = "weekly"
    }
  }

  authentication_profiles = {
    example = {
      name = "example"
      content = {
        AllowDBUserOverride = "1"
        Client_ID           = "ExampleClientID"
        App_ID              = "example"
      }
    }
  }

  tags = {
    terraform = true
  }
}