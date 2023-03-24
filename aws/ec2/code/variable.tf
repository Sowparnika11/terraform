variable "location"{
    default = null
}
variable "create" {
    type = bool
    description = "to decide whether EC2 instance needs to be created or not"
    default = true
}
variable "is_block_device"{
  type = bool 
  description = "to decide whether root block device is required or not "
  default = true
}
variable "is_ebs_required"{
  type = bool 
  description = "to decide whether root EBS block device is required or not "
  default = true
}
variable "create_spot_instance" {
  description = "Depicts if the instance is a spot instance"
  type        = bool
  default     = false
}
variable "instance_type" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}
variable "availability_zone" {
  type        = string
  description = "Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region"
  default     = ""
}
variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}
variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}
variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = null
}
variable "instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
  default     = null
}
variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = null
}
variable "ssh_key_pair" {
  type        = string
  description = "SSH key pair to be provisioned on the instance"
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}
variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}
variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = true # as part of security 
}
variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = true  # it should be true as per trivy security rule
}
variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}
variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}
variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
}
variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  type        = number
  default     = null
}
variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Whether the metadata service is available"
}
variable "metadata_tags_enabled" {
  type        = bool
  default     = false
  description = "Whether the tags are enabled in the metadata service."
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 2
  description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
}
variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
}
variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = null
}
variable "launch_template" {
  description = "Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template"
  type        = map(string)
  default     = null
}
variable "is_launch_template" {
  description = "decides whether launch template is required or not"
  type        = bool
  default     = false
}
variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "enable_volume_tags" {
  description = "Whether to enable volume tags (if enabled it conflicts with root_block_device tags)"
  type        = bool
  default     = true
}
variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}
variable "ebs_block_device_name"{
  type = string 
  description = "Name of the device to mount"
  default = "/dev/sdf"
}
variable "get_password" {
  type = bool # only for windows it should be true
  description = "If true, wait for password data to become available and retrieve it. Useful for getting the administrator password for instances running Microsoft Windows"
  default = false
}
variable "create_alarm"{
  type = bool 
  description = "To decide whether the alarm is to be craeted or not"
  default = false
}
variable "alarm_name"{
  type = string 
  description = "The descriptive name for the alarm"
  default = "cpu-utilization"
}
variable "comparison_operator"{
  type = string 
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
  default = "GreaterThanOrEqualToThreshold"
}
variable "evaluation_periods"{
  type = number
  description = "The number of periods over which data is compared to the specified threshold"
  default = 1
}
variable "metric_name"{
  type = string 
  description = "The name for the alarm's associated metric"
  default = "CPUUtilization"
}
variable "namespace"{
  type = string 
  description = "The namespace for the alarm's associated metric"
  default = "AWS/EC2"
}
variable "period"{
  type = number
  description = "The period in seconds over which the specified statistic is applied"
  default = 120
}
variable "statistic"{
  type = string 
  description = "The statistic to apply to the alarm's associated metric."
  default = "Average"
}
variable "threshold"{
  type = number 
  description = "The value against which the specified statistic is compared."
  default = 80
}
variable "alarm_description"{
  type = string 
  description = "The description for the alarm"
  default = ""
}
variable "insufficient_data_actions"{
  type = list(any) 
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state."
  default = []
}
variable "dimensions"{
  type = map 
  description = "Dimensions for metrics."
  default = {}
}

