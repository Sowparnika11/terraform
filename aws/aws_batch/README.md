AWS Batch
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

AWS Batch helps you to run batch computing workloads on the AWS Cloud. Batch computing is a common way for developers, scientists, and engineers to access large amounts of compute resources.AWS Batch helps you to run batch computing workloads of any scale. AWS Batch automatically provisions compute resources and optimizes the workload distribution based on the quantity and scale of the workloads. With AWS Batch, there's no need to install or manage batch computing software, so you can focus your time on analyzing results and solving problems.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Examples
- With minimum parameters
   ```hcl
   module "batch_creation" {
    source               = "./code"
    location  = "eu-west-2"
    vpc_id = "vpc-09a8c77ae21f28516"
    subnet_id  = "subnet-073f346b28ccddaf6"
   }
   ```
- With all parameters
  ```hcl 
   module "batch_creation" {
    source               = "./code"
    location             = "eu-west-2"
    vpc_id               = "vpc-09a8c77ae21f28516"
    subnet_id            = "subnet-073f346b28ccddaf6"
    env_name             = "sample-env-for-batch"
    max_vcpu             = 2
    min_vcpu             = 1
    desired_vcpu         = 1
    resource_type        = "EC2"
    env_type             = "MANAGED"
    queue_name           = "sample-queue"
    queue_status         = "ENABLED"
    queue_priority       = 1
    job_definition_name  = "sample-job-definition"
    job_type             = "container"
    container_properties   = file("./code/data/job_definition.json")
    retry_strategy = {
        attempts = 3
        evaluate_on_exit = {
          retry_error = {
            action       = "RETRY"
            on_exit_code = 1
          }
          exit_success = {
            action       = "EXIT"
            on_exit_code = 0
          }
        }
      }
   }
 ```

## Requirements

| Name  | Version |
| ----- | ------- |
| Terraform | >= 0.13 |
| Aws  | >= 4.13.0 |

## Providers

| Name  | Version |
| ----- | ------- |
| Aws  | >= 4.13.0 |

## Resource

| Name | Type |
|----- | ---- |
| aws_iam_role.ecs_instance_role | Resource |
| aws_iam_role_policy_attachment.ecs_role_policy_attachement | Resource |
| aws_iam_instance_profile.ecs_instance_role_profile | Resource |
| aws_iam_role.aws_batch_service_role | Resource |
| aws_iam_role_policy_attachment.batch_role_policy_attachment | Resource |
| aws_security_group.sample_security_group | Resource |
| aws_batch_compute_environment.sample_env | Resource |
| aws_batch_job_queue.sample_job_queue | Resource |
| aws_batch_job_definition.sample_job_definition | Resource |

## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| vpc_id | VPC ID to launch Compute Environment| `string` | Null | Yes|
| location | location of the aws region | `string` | Null | Yes|
| subnet_id | A list of VPC subnets into which the compute resources are launched | `list(string)` | [] | yes|
| instance_type |The instance_type for compute environment to use | `string` | Null | No|
| max_vcpu | The maximum number of EC2 vCPUs that an environment can reach| `number` | 2 | Yes|
| min_vcpu | The minimum number of EC2 vCPUs that an environment should maintain| `number` | NA | No|
| desired_vcpu | The desired number of EC2 vCPUS in the compute environment  | `number` | NA | No|
| resource_type |The type of compute environment |`string` | EC2 | Yes|
| env_name | The name for your compute environment resource | `string` | NA | Yes|
| env_type | The name for your compute environment | `string` | MANAGED | Yes|
| queue_name |Specifies the name of the job queue. | `string` | NA | Yes |
| queue_state | The state of the job queue. Must be one of: ENABLED or DISABLED| `string` | NA | Yes |
| queue_priority | TThe priority of the job queue. Job queues with a higher priority are evaluated first when associated with the same compute environment | `string` | NA | No|
| job_definition_name | Specifies the name of the job definition | `string` | NA | Yes|
| job_type | The type of job definition. Must be container | `string` | container | Yes |
| container_properties | A valid container properties provided as a single valid JSON document | `map/json file` |   | Yes|
| retry_strategy | Specifies the retry strategy to use for failed jobs that are submitted with this job definition | `any` | null | Yes|
| target_prefix | A prefix for all log object key | `string` | "" | Yes|


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)