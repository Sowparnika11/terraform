AWS Security Group
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

A security group controls the traffic that is allowed to reach and leave the resources that it is associated with. For example, after you associate a security group with an EC2 instance, it controls the inbound and outbound traffic for the instance.When you create a VPC, it comes with a default security group. You can create additional security groups for each VPC. You can associate a security group only with resources in the VPC for which it is created.For each security group, you add rules that control the traffic based on protocols and port numbers. There are separate sets of rules for inbound traffic and outbound traffic.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Examples
- With minimum parameters
   ```hcl
   module "create_security_group" {
      source                    = "./code"
      location                  = "eu-west-2"
      create_sg                 = true
      name                      = "DEVOPS-MADES-EASY-SG"
      description               = "DEVOPS-MADES-EASY description"
      vpc_id                    = "vpc-09a8c77ae21f28516"
      tags                      = { Name = "sample sg"}
   }
   ```
- With all parameters
  ```hcl 
   module "create_security_group" {
      source                    = "./code"
      location                  = "eu-west-2"
      create_sg                 = true
      name                      = "DEVOPS-MADES-EASY-SG"
      description               = "DEVOPS-MADES-EASY description"
      vpc_id                    = "vpc-09a8c77ae21f28516"
      ingress_description       = "description for ingress"
      ingress_from              = 443
      ingress_to                = 443
      ingress_protocol          = "tcp"
      vpc_cidr                  = ["10.0.0.0/16"]
      ipv6_cidr                 = []
      egress_from               = 0
      egress_to                 = 0
      egress_protocol           = -1
      egress_cidr               = ["0.0.0.0/0"]
      egress_ipv6_cidr          = ["::/0"]
      tags                      = { Name = "sample sg"}
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
| aws_security_group.create_sg | Resource |

## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| name | The name of the security group | `string` | Null | No|
| create_sg | to decide whether security group has to be created or not | `bool` | yes | Yes|
| location | location of the aws region | `string` | Null | Yes|
| tags | A mapping of tags to assign to the security group. | `map(any)` | {} | No|
| description | Security group description | `string` | Null | No|
| vpc_id | Id of vpc.Defaults to the region's default VPC| `string` | NA | Yes|
| ingress_description |Description of this ingress rule| `string` | NA | No|
| ingress_from | Ingress start port | `number` | 443 | Yes|
| ingress_to | Ingress end port |`number` | 443 | Yes|
| ingress_protocol | The protocol used for ingress | `string` | tcp | Yes|
| vpc_cidr | List of ingress rules to create where 'cidr_blocks' is used | `list(string)` | [] | No|
| ipv6_cidr | List of ingress rules to create where 'ipv6_cidr_blocks' is used | `list(string)` | [] | No|
| egress_from | Egress from port | `number` | 0 | No|
| egress_to | Egress to port | `number` | 0 | No|
| egress_protocol | egress protocol | `string` | -1 | Yes|
| egress_cidr | List of egress rules to create where 'cidr_blocks' is used | `list(string)` | ["0.0.0.0/0"] | No|
| egress_ipv6_cidr  | List of IPv6 CIDR blocks | `list(string)`| ["::/0"]  | No|

## Output


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)