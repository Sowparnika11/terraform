# #################################################################################################
# Variables for Controlling the All Module 
# #################################################################################################

variable "create_all" {
  description = "Switch to turn the Module on or off."
  type        = bool
  default     = true
}

# #################################################################################################
# Variables for the User to Subsitute Resources with
# #################################################################################################

variable "use_own_kms_key" {
  description = "Specifies whether the User has created a KMS Key outside the Module, to use for the Redshift Cluster."
  type        = bool
  default     = false
}

variable "created_kms_key_arn" {
  description = "ARN of KMS Key. Variable used if you create a KMS Key outside the Module. Needs enable_encryption_at_rest and use_own_kms_key to be set to True."
  type        = string
  default     = ""
}

variable "use_own_s3_log" {
  description = "Specifies whether the User has created a S3 Log outside the Module, to use for the Redshift Cluster."
  type        = bool
  default     = false
}

variable "created_s3_log_name" {
  description = "Name of S3 Bucket you want Logs to be stored in. Variable used if you create a S3 Log outside the Module. Needs enable_logging_to_s3 and use_own_s3_log to be set to True."
  type        = string
  default     = ""
}

variable "use_own_vpc" {
  description = "Specifies whether the user has created a VPC outside the Module, to use for the Redshift Cluster."
  type        = bool
  default     = false
}

variable "created_vpc_redshift_subnet_ids" {
  description = "VPC Redshift Subnet IDs you want the Redshift Cluster to be connected to. Variable used if you create a VPC outside the Module. Needs use_own_vpc to be set to True."
  type        = list(string)
  default     = []
}

variable "created_vpc_private_subnet_ids" {
  description = "VPC Private Subnet IDs you want the Redshift Cluster to be connected to. Variable used if you create a VPC outside the Module. Needs use_own_vpc to be set to True."
  type        = list(string)
  default     = []
}

variable "created_vpc_security_group_id" {
  description = "Name of S3 Bucket you want logs to be stored in. Variable used if you create a VPC outside the module. Needs use_own_vpc to be set to True."
  type        = string
  default     = ""
}

# #################################################################################################
# Variables for the VPC Module
# #################################################################################################

variable "enable_enhanced_vpc_routing" {
  description = "Enables or Disables Enhanced VPC Routing for the Redshift Cluster."
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "List of Availability Zones to use for the Subnets in the VPC."
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "CIDR Block for the VPC. CIDR Block parameter must be in the form x.x.x.x/16-28."
  type        = string
  default     = ""
}

variable "private_subnet_cidrs" {
  description = "CIDR Block for Private Subnets, located in the Availability Zones. CIDR Block parameter must be in the form x.x.x.x/16-28."
  type        = list(string)
  default     = []
}

variable "redshift_subnet_cidrs" {
  description = "CIDR Block for Redshift Subnets, located in the Availability Zones. CIDR Block parameter must be in the form x.x.x.x/16-28."
  type        = list(string)
  default     = []
}

# #################################################################################################
# Variables for the S3 Logs Module
# #################################################################################################

variable "enable_logging_to_s3" {
  description = "Enables or Disables logging to an S3 Bucket. To Enable Logging, select True."
  type        = bool
  default     = true
}

variable "s3_logs_enable_attach_deny_insecure_transport_policy" {
  description = "Controls if S3 Logs Bucket should have deny Non-SSL Transport Policy attached."
  type        = bool
  default     = true
}

variable "s3_logs_force_destroy" {
  description = " A Boolean that indicates all objects should be deleted from the S3 Logs Bucket so that the Bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = true
}

variable "s3_logs_block_public_acls" {
  description = "Whether Amazon S3 should block Public ACLs for the S3 Logs Bucket."
  type        = bool
  default     = true
}

variable "s3_logs_block_public_policy" {
  description = "Whether Amazon S3 should block Public Bucket Policies for the S3 Logs Bucket."
  type        = bool
  default     = true
}

variable "s3_logs_ignore_public_acls" {
  description = "Whether Amazon S3 should ignore Public ACLs for the S3 Logs Bucket."
  type        = bool
  default     = true
}

variable "s3_logs_restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict Public Bucket Policies for the S3 Logs Bucket."
  type        = bool
  default     = true
}

# #################################################################################################
# Variables for the KMS Key Resource if encryption is enabled
# #################################################################################################

variable "enable_encryption_at_rest" {
  description = "Enables or Disables Encryption at Rest of the Redshift Cluster."
  type        = bool
  default     = true
}

variable "key_deletion_window_in_days" {
  description = "The amount of days the KMS key for the Redshift Cluster will be used before deletion."
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Allows for the rotation of KMS Keys for the Redshift Cluster."
  type        = bool
  default     = true
}

# #################################################################################################
# Variables for the Redshift Cluster Module
# #################################################################################################

variable "master_user_name" {
  description = "The Username that is associated with the Master User Account for the Cluster that is being created. Must start with a-z and contain only a-z or 0-9."
  type        = string
}

variable "master_user_password" {
  description = "The Password that is associated with the Master User Account for the Cluster that is being created. Set enable_random_password to True, to ignore this variable. Must have at least 8 Characters and no more than 64 Characters, and must include 1 Uppercase Letter, 1 Lowercase Letter, 1 Number, and 1 Symbol (excluding / @ \" ')."
  type        = string
  default     = null
}

variable "enable_random_password" {
  description = "Enables or Disables the creating and use of a Random Password."
  type        = bool
  default     = true
}

variable "node_type" {
  description = "The type of Node to be provisioned."
  type        = string
  validation {
    condition = contains([
      "ds2.xlarge",
      "ds2.8xlarge",
      "dc2.large",
      "dc2.8xlarge",
      "ra3.xlplus",
      "ra3.4xlarge",
      "ra3.16xlarge"
    ], var.node_type)
    error_message = "The node_type must be either ds2.xlarge, ds2.8xlarge, dc2.large, dc2.8xlarge, ra3.xlplus, ra3.4xlarge, ra3.16xlarge."
  }
}

variable "number_of_nodes" {
  description = "The number of compute nodes in the Cluster. For Multi-Node Clusters, the number_of_nodes variable must be greater than 1."
  type        = number
}

variable "database_name" {
  description = "The name of the first Database to be created when the Cluster is created."
  type        = string
  default     = "test_database"
}

variable "maintenance_window" {
  description = "The maintenance window for the Redshift Cluster."
  type        = string
  default     = ""
}

variable "redshift_cluster_port" {
  description = "The Port Number on which the Cluster accepts incoming connections."
  type        = number
}

variable "enable_availability_zone_relocation" {
  description = "Enables of Disables Availability Zone Relocation. To enable, select True. Only available when using ra3.x type."
  type        = bool
  default     = false
}

variable "enable_endpoint_access" {
  description = "Enables or Disables Endpoint Access. To enable, select True. Only available when the enable_availability_zone_relocation variable is set to True."
  type        = bool
  default     = false
}

variable "allow_version_upgrade" {
  description = "If True, major version upgrades can be applied during the Maintenance Window to the Amazon Redshift engine that is running on the Cluster."
  type        = bool
  default     = true
}

variable "make_redshift_publicly_accessible" {
  description = "Specifies whether Amazon Redshift will be Publicly Accessible."
  type        = bool
  default     = false
}

# ################################################
# Variables Redshift Snapshot Schedule, if enabled
# ################################################

variable "enable_snapshot_schedule" {
  description = "Enables or Disables the Snapshot Schedule Feature. To enable, select True."
  type        = bool
  default     = false
}

variable "snapshot_schedule_definition" {
  description = "The amount of the time between each Snapshot."
  type        = list(string)
  default     = []
}

variable "snapshot_schedule_force_destroy" {
  description = "Whether to destroy all associated Clusters with this Snapshot Schedule on deletion. Must be enabled and applied before attempting deletion."
  type        = bool
  default     = true
}

# ################################################
# Variables for the Complex Map Variables
# ################################################

variable "parameters" {
  description = "A List of Parameters that you can use for the Redshift Cluster."
  type        = any
  default     = {}
}

variable "scheduled_actions" {
  description = "A map of maps containing Scheduled Action details."
  type        = any
  default     = {}
}

variable "usage_limits" {
  description = "Map of Usage Limit defintions to create."
  type        = any
  default     = {}
}

variable "authentication_profiles" {
  description = "Map of Authentication Profiles to create."
  type        = any
  default     = {}
}

# #################################################################################################
# Other Variables
# #################################################################################################

variable "name" {
  description = "Name for all the Resources, the module will add suffixes for the different Resources."
  type        = string
}

variable "tags" {
  description = "Tags for all the Resources."
  type        = map(any)
  default     = {}
}