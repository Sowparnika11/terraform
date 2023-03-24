variable "vpc_id" {
  type = string
  description = "VPC ID to launch Compute Environment."
}
variable "location" {
  default = null
}
variable "subnet_id" {
  type = list(string)
  description = "A list of VPC subnets into which the compute resources are launched"
  default = []
}

variable "instance_type"{
  type = string
  description = "The instance_type for compute environment to use."
  default = "optimal"
}
variable "max_vcpu"{
  type = number
  description = "The maximum number of EC2 vCPUs that an environment can reach"
  default = 2
}
variable "min_vcpu"{
  type = number
  description = "The minimum number of EC2 vCPUs that an environment should maintain"
  default = 1
}
variable "desired_vcpu"{
  type = number
  description = "The desired number of EC2 vCPUS in the compute environment"
  default = 1
}
variable "resource_type"{
  type  = string
  description = "The type of compute environment"
  default = "EC2"
}
variable "env_name"{
  type = string
  description = "The name for your compute environment resource"
  default     = "sample_env"
}
variable "env_type"{
  type  = string
  description = "The type of the compute environment. Valid items are MANAGED or UNMANAGED"
  default = "MANAGED"
}
variable "queue_name"{
  type  = string
  description = "specifies the name of the job queue"
  default = "sample_queue"
}
variable "queue_state"{
  type  =string
  default = "ENABLED"
}
variable "queue_priority"{
  type  = number
  description = "The priority of the job queue. Job queues with a higher priority are evaluated first when associated with the same compute environment"
  default = 1
}
variable "job_definition_name"{
  type  =string
  description = "Specifies the name of the job definition"
  default = "job_defenition_sample"
}
variable "job_type"{
  type  =string
  description = "The type of job definition. Must be container"
  default = "container"
}
//  Map or json file with defined ec2_container_properties.
variable "container_properties" {
  description = "A valid container properties provided as a single valid JSON document."
}
variable "retry_strategy"{
  type = any
  description ="Specifies the retry strategy to use for failed jobs that are submitted with this job definition"
  default = null
}
