## Amazon Virtual Private Cloud (Amazon VPC)

![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Examples
- With minimum parameters
  ```hcl
  module "create_vpc" {
    location      = "eu-west-2"
    is_vpc         = true
    name_prefix = "sample"
    cidr        = "10.20.0.0/16"
    prv_cidr_block_subnet = ["10.20.1.0/24","10.20.2.0/24"]
    pub_cidr_block_subnet = ["10.20.3.0/24","10.20.4.0/24"]
    az_subnet = ["eu-west-2a","eu-west-2b"]
    vpc_tag = {
        "Name"  = "owner name"
    }
  }
  ```
- With maximum parameters
  ```hcl
  module "create_vpc" {
    location   = "eu-west-2"
    is_vpc     = true
    name_prefix = "sample"
    cidr = "10.20.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = false
    instance_tenancy = default
    prv_cidr_block_subnet = ["10.20.1.0/24","10.20.2.0/24"]
    pub_cidr_block_subnet = ["10.20.3.0/24","10.20.4.0/24"]
    az_subnet = ["eu-west-2a","eu-west-2b"]
    vpc_tag = {
        "Name"  = "owner name"
    }
    create_internet_gateway = true
    single_nat_gateway = false
    one_nat_gateway_per_az = true
    enable_nat_gateway = true
    enable_ipv6 = true
  }
  ```

## Requirements

| Name  | Version |
| ----- | ------- |
| <a name="requirement_aws"></a> [AWS](#requirement\_aws) | >= 4.13.0 |
| <a name="requirement_terraform"></a> [Terraform](#requirement\_aws) | >= 0.13 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.3.0 |
| <a name="requirement_helm"></a> [Helm](#requirement\_helm) | >= 2.5.1 |


## Providers

| Name  | Version |
| ----- | ------- |
| <a name="provider_aws"></a> [Aws](#provider\_aws) | >= 4.13.0 |
| <a name="provider_Kubernetes"></a> [Kubernetes](#provider\_Kubernetes) | >= 4.13.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.13.0 |

## Resource

| Name | Type |
|----- | ---- |
| aws_vpc.my_vpc | Resource |
| aws_subnet.prv_subnets | Resource |
| aws_subnet.pub_subnets| Resource |
| aws_default_security_group.default | Resource|
| aws_route_table.prv_route_tables| Resource |
| aws_route_table.pub_route_tables | Resource|
| aws_route_table_association.prv_subnet_association | Resource|
| aws_route_table_association.pub_subnet_association | Resource|
| aws_internet_gateway.public| Resource |
| aws_egress_only_internet_gateway.egress_igw| Resource |
| aws_route.public_internet_gateway| Resource |
| aws_route.public_internet_gateway_ipv6 | Resource |
| aws_route.private_ipv6_egress| Resource |
| aws_eip.nat_eip| Resource |
| aws_nat_gateway.nat| Resource |
| aws_route.private_nat_gateway| Resource |



## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string` | "0.0.0.0/0" | No|
| is_vpc | to decide whether vpc to be created or not | `bool` | yes | Yes|
| location | location of the aws region | `string` | Null | Yes|
| prv_cidr_block_subnet | list of private subnet cidr | `list(string)` | [] | yes|
| pub_cidr_block_subnet | list of private subnet cidr | `list(string)` | [] | yes|
| az_subnet | list of avaialability zone,length should be equal to no of subnets | `list(string)` | [] | yes|
| vpc_tag | tags for the vpc | `map(any)` | Null | No|
| create_internet_gateway | to decide whether Internet gatway to be created or not | `bool` | false | No|
| instance_tenancy | A tenancy option for instances launched into the VPC | `string` | default | No|
| enable_dns_hostnames | A boolean flag to enable/disable DNS hostnames in the VPC | `string` | false | No|
| enable_dns_support | A boolean flag to enable/disable DNS support in the VPC | `bool` | true | No|
| enable_ipv6 | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block | `bool` | false | No|
| enable_classiclink | Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic | `bool` | Null | No|
| enable_classiclink_dns_support | Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic | `bool` | Null | No|
| create_egress_only_igw | Controls if an Egress Only Internet Gateway is created and its related routes | `bool` | False | No|
| igw_tags | Additional tags for the internet gateway | `map(string)` | {} | No|
| name_prefix | to identify the resource provide name prefix | `string` | Null | No|
| single_nat_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | false | No|
| one_nat_gateway_per_az | Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs` | `bool` | false | No|
| reuse_nat_ips | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable | `bool` | false | No|
| enable_nat_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | `bool` | false | No|
| external_nat_ip_ids | list(string) | `list(string)` | [] | No|
| nat_eip_tags | Additional tags for the NAT EIP | `map(string)` | {} | No|
| nat_gateway_tags | Additional tags for the NAT gateways | `map(string)` | {} | No|
| nat_gateway_destination_cidr_block | Used to pass a custom destination route for private NAT Gateway. If not specified, the default 0.0.0.0/0 is used as a destination route | `string` | 0.0.0.0/0 | No|

## Output 


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)




