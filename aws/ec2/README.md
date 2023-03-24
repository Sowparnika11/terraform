AWS EC2 Terraform module
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Amazon Elastic Compute Cloud (Amazon EC2) provides scalable computing capacity in the Amazon Web Services (AWS) Cloud. Using Amazon EC2 eliminates your need to invest in hardware up front, so you can develop and deploy applications faster.Amazon EC2 enables you to scale up or down to handle changes in requirements or spikes in popularity, reducing your need to forecast traffic.
This AWS EC2 template will enable the features like attaching root_block_device and ebs_block_device, enabled meta http endpoints and launch template, remote login using ssh key.


## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Examples
- With minimum parameters
  ```hcl
  module "ec2_creation"{
    location  = "eu-west-2"
    create = true
    create_spot_instance = false
    ami = "ami-0fb391cce7a602d1f"
    instance_type = "t3.micro"
    subnet_id = "subnet-073f346b28ccddaf6"
    vpc_security_group_ids = ["sg-073a6137f38de530c"]
    associate_public_ip_address = false
    disable_api_termination = true
    enable_volume_tags = false
    ebs_block_device_name ="/dev/sdf"
    create_alarm = true
    alarm_name  = "cpu-utilization" 
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 2
  }
  ```
  
- With all parameters
``` hcl
module "ec2_creation"{
  location  = "eu-west-2"
  create = true 
  create_spot_instance = false
  ami = "ami-00785f4835c6acf64"
  instance_type = "t3.micro"
  subnet_id = "subnet-123456"
  vpc_security_group_ids = ["sg-0d678898766"]
  associate_public_ip_address = false
  disable_api_termination = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]
  ebs_block_device = [
    {
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
      encrypted   = true
    }
  ]
  metadata_http_endpoint_enabled = true
  metadata_tags_enabled = false
  metadata_http_tokens_required = true
  is_launch_template = false
  ebs_block_device_name ="/dev/sdf"
  create_alarm = true 
  alarm_name  = "cpu-utilization" 
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period  = 120
  statistic = "Average"
  threshold = 80
  alarm_description = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}
```

## Requirements

| Name  | Version |
| ----- | ------- |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.13.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |


## Providers

| Name  | Version |
| ----- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.13.0 |

## Resource

| Name | Type |
|----- | ---- |
| aws_instance.sample | Resource |
| aws_cloudwatch_metric_alarm.ec2_cpu | Resource |

## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| location | location of the aws region | `string` | Null | Yes|
| create | to decide whether EC2 to be created or not | `bool` | true | yes |
| is_block_device | to decide whether root block device is required or not | `bool` | true | No |
| is_ebs_required | to decide whether root EBS block device is required or not | `bool` | true | No |
| create_spot_instance | Depicts if the instance is a spot instance | `bool` | false | No |
| instance_type | The type of the instance | `string` | Null | yes |
| availability_zone | Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region | `string` | Null | No |
| subnet_id | The VPC Subnet ID to launch in | `string` | Null | No |
| vpc_security_group_ids | A list of security group IDs to associate with | `list(string)` | Null | no |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | true | Yes |
| disable_api_termination | If true, enables EC2 Instance Termination Protection | `bool` | Null | no |
| instance_profile | IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile | `string` | Null | No |
| instance_initiated_shutdown_behavior | Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance | `string` | Null | No |
| ssh_key_pair | SSH key pair to be provisioned on the instance | `string` | Null | No |
| user_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument | `string` | Null | No |
| associate_public_ip_address | Whether to associate a public IP address with an instance in a VPC | `bool` | true | No |
| ami | ID of AMI to use for the instance | `string` | Null | No |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | true | No |
| key_name | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | Null | No |
| private_ip | Private IP address to associate with the instance in a VPC | `string` | Null | No |
| source_dest_check | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs | `bool` | true | No |
| root_block_device | Customize details about the root block device of the instance. See Block Devices below for details | `list(any)` | [] | No |
| metadata_http_endpoint_enabled | Whether the tags are enabled in the metadata service | `bool` | false | No |
| metadata_http_put_response_hop_limit | The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests | `number` | 2 | No |
| metadata_http_tokens_required | Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 | `bool` | true | No |
| cpu_credits | The credit option for CPU usage (unlimited or standard) | `string` | Null | No |
| launch_template | Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template | `map(string)` | Null | No |
| is_launch_template | decides whether launch template is required or not | bool | false | No |
| timeouts | Define maximum timeout for creating, updating, and deleting EC2 instance resources | `map(string)` | {} | No |
| enable_volume_tags | Whether to enable volume tags (if enabled it conflicts with root_block_device tags) | bool | true | No |
| volume_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | {} | No |
| ebs_block_device | Additional EBS block devices to attach to the instance | list(map(string)) | [] | No |
| ebs_block_device_name | Name of the device to mount(required if ebs block enabled) | `string` | Null | No |
| create_alarm | To decide whether alaram should be created or not  | `bool` | true | Yes |
| comparison_operator | The arithmetic operation to use when comparing the specified Statistic and Threshold| `string` | GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold | Yes |
| evaluation_periods |The number of periods over which data is compared to the specified threshold | `Number` | 1 | Yes |
| metric_name | The name for the alarm's associated metric | `string` | CPUUtilization | No |
| namespace | The namespace for the alarm's associated metric | `string` | "AWS/EC2" | No |
| period | The period in seconds over which the specified statistic is applied | `number` | Null | No |
| statistic | The statistic to apply to the alarm's associated metric | `string` | Null | No |
| threshold | The value against which the specified statistic is compared | `Number` | Null | No |
| alarm_description | The description for the alarm | `string` | "" | No |
| insufficient_data_actions | The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state | `list(any)` | [] | No |
| dimensions | Dimensions for metrics | `map` | {} | No |


## Output

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)





