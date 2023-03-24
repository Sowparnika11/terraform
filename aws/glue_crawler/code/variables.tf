# #################################################################################################
# Controls to create the resources needed for the Crawler 
# #################################################################################################

variable "create_all" {
  description = "Switch to turn the module on or off."
  type        = bool
  default     = true
}

variable "create_catalog_database" {
  description = "Controls if a Catalog Database should be Created."
  type        = bool
  default     = true
}

variable "create_crawler" {
  description = "Controls if the Crawler should be Created."
  type        = bool
  default     = true
}

variable "create_iam_role" {
  description = "Controls if an IAM Role should be Created."
  type        = bool
  default     = true
}

# #################################################################################################
# Variables for your own IAM Role and Catalog Database
# #################################################################################################

variable "catalog_database_for_crawler" {
  description = "(Optional) Name of the Catalog Database if you did not create one using the module. Needs create_catalog_database variable to be false."
  type        = string
  default     = ""
}

variable "role_arn_for_crawler" {
  description = "(Optional) ARN of IAM Role if you did not create one using the module. Needs create_iam_role variable to be false."
  type        = string
  default     = ""
}

# #################################################################################################
# Variables for the Catalog Database
# #################################################################################################

variable "catalog_database_name" {
  description = "(Required) Name to be used on the Catalog Database."
  type        = string
  default     = ""
}

variable "catalog_database_description" {
  description = "(Optional) The description of the Catalog Database."
  type        = string
  default     = ""
}

variable "catalog_database_catalog_id" {
  description = "(Optional) ID of the Glue Catalog to create the database in. If omitted this defaults to the AWS Account ID."
  type        = string
  default     = ""
}

variable "catalog_database_location_uri" {
  description = "(Optional) Location of the database (for example, an HDFS path)."
  type        = string
  default     = ""
}

variable "catalog_database_parameters" {
  description = "(Optional) List of key-value pairs that define parameters and properties of the database."
  type        = map(any)
  default     = {}
}

# ################################################
# Variables for the target_database Configuration Block
# ################################################

variable "td_catalog_id" {
  description = "(Required, if you want to use the target_database feature) ID of the Data Catalog in which the database resides."
  type        = string
  default     = ""
}

variable "td_database_name" {
  description = "(Required, if you want to use the target_database feature) Name of the catalog database."
  type        = string
  default     = ""
}

# ################################################
# Variables for the create_table_default_permission Configuration Block
# ################################################

variable "ctdfp_permissions" {
  description = "(Optional) The permissions that are granted to the principal."
  type        = list(any)
  default     = []
}

variable "ctdfp_data_lake_principal_identifier" {
  description = "(Optional) An identifier for the Lake Formation principal."
  type        = string
  default     = ""
}

# #################################################################################################
# Variables for the Glue Crawler 
# #################################################################################################

variable "glue_crawlers" {
  description = "(Required) List of maps to create mulitple Crawlers for a single Catalog Database"
  type        = any
  default     = []
}

# #################################################################################################
# Other Variables
# #################################################################################################

variable "tags" {
  description = "Tags to use on all the resources"
  type        = any
  default     = {}
}