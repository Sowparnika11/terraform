# Aws Elastic Kubernetes Services
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Amazon Elastic Kubernetes Service (Amazon EKS) is a managed service that you can use to run Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane or nodes. Kubernetes is an open-source system for automating the deployment, scaling, and management of containerized applications
This terraform module creates EKS cluster with node groups, Iam role , security groups, cloudwatch log group etc...

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Example
- With minimum parameters
```hcl
module "eks" {
  source   = "../aws/aws_eks/code"
  location                             = "eu-west-2"
  eks_cluster_name                     = "sample"
  subnet_ids                           = ["subnet-xxx1", "subnet-xxx2", "subnet-xx3"]
}

```
- With maximum parameters
```hcl
module "eks_cluster_1" {
  source                               = "../aws/aws_eks/code"
  location                             = "eu-central-1"                                            ## Mandatory
  eks_cluster_name                     = "poc-cluster-eucent1-01"                                          ## Mandatory
  subnet_ids                           = ["subnet-xxxxx", "subnet-xxxxx", "subnet-xxxxx"] ## Mandatory
  cluster_log_types                    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  eks_cluster_version                  = 1.24            ## Optional
  cluster_endpoint_private_access      = true            ## Optional 
  cluster_endpoint_public_access       = true            ## Optional
  cluster_endpoint_public_access_cidrs = null            ## Optional 
  service_ipv4_cidr                    = "172.30.0.0/16" ## Optional 
  log_retention_in_days                = 14              ## Optional
  ##Node Group
  node_desired_size    = 1             ## Optional 
  node_max_size        = 4             ## Optional 
  node_min_size        = 1             ## Optional  
  node_instance_types  = ["t2.medium"] ## Optional   
  node_disk_size       = 50            ## Optional  
  node_ami_type        = "AL2_x86_64"  ## Optional   
  node_max_unavailable = 1             ## Optional  
  node_capacity_type   = "ON_DEMAND"   ## Optional   
  tags = {                             ## Optional
    "Created by " = "Abhilash"         ## Optional
    "Env"         = "POC"              ## Optional
  }
  enable_oidc_openid_connect   = true
  enable_addon_coredns         = true
  coredns_addon_version        = null
  enable_addon_kube_proxy      = true
  kube_proxy_addon_version     = null
  enable_addon_ebs_csi_driver  = true
  ebs_csi_driver_addon_version = null
  enable_addon_vpc_cni         = true
  vpc_cni_addon_version        = null

  create_cluster_autoscaler = true
  create_metrics_server     = true
}

```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.53.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.8.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.53.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | = 2.8.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_addon.eks_coredns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.eks_ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.eks_kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.eks_vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_identity_provider_config.eks_identity_provider_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_identity_provider_config) | resource |
| [aws_eks_node_group.eks_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.eks_iam_openid_connect_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.eks-cluster-autoscaler-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks-cluster-openid_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_nodegroup_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSVPCResourceController](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_ebs_csi_driver_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-cluster-AutoScalingFullAccess-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-cluster-autoscaler-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.eks_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.eks_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.eks_cluster_securitygroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release) | resource |
| [aws_caller_identity.caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.eks-cluster-openid_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.eks_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [tls_certificate.eks_tls_certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | (Optional) Whether the Amazon EKS private API server endpoint is enabled. Default is false. | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | (Optional) Whether the Amazon EKS public API server endpoint is enabled. Default is true. | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | (Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration. | `list(string)` | `null` | no |
| <a name="input_cluster_log_types"></a> [cluster\_log\_types](#input\_cluster\_log\_types) | (Optional) List of the desired control plane logging to enable | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_coredns_addon_version"></a> [coredns\_addon\_version](#input\_coredns\_addon\_version) | (Optional) Specify the Add-ons version or use null for default value to use | `string` | `null` | no |
| <a name="input_create_cluster_autoscaler"></a> [create\_cluster\_autoscaler](#input\_create\_cluster\_autoscaler) | (Optional) Enable or disable  helm cluster auto scaler | `bool` | `false` | no |
| <a name="input_create_metrics_server"></a> [create\_metrics\_server](#input\_create\_metrics\_server) | (Optional) Enable or disable  helm metrics server | `bool` | `false` | no |
| <a name="input_ebs_csi_driver_addon_version"></a> [ebs\_csi\_driver\_addon\_version](#input\_ebs\_csi\_driver\_addon\_version) | (Optional) Specify the Add-ons version or use null for default value to use | `string` | `null` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | (Required) Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters | `string` | `null` | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS | `string` | `null` | no |
| <a name="input_enable_addon_coredns"></a> [enable\_addon\_coredns](#input\_enable\_addon\_coredns) | (Optional) Enable or disable Add-ons for CoreDNS | `bool` | `false` | no |
| <a name="input_enable_addon_ebs_csi_driver"></a> [enable\_addon\_ebs\_csi\_driver](#input\_enable\_addon\_ebs\_csi\_driver) | (Optional) Enable or disable  Add-ons for Amazon EBS CSI Driver | `bool` | `false` | no |
| <a name="input_enable_addon_kube_proxy"></a> [enable\_addon\_kube\_proxy](#input\_enable\_addon\_kube\_proxy) | (Optional) Enable or disable Add-ons for kube-proxy | `bool` | `false` | no |
| <a name="input_enable_addon_vpc_cni"></a> [enable\_addon\_vpc\_cni](#input\_enable\_addon\_vpc\_cni) | (Optional) Enable or disable  Add-ons for Amazon VPC CNI | `bool` | `false` | no |
| <a name="input_enable_oidc_openid_connect"></a> [enable\_oidc\_openid\_connect](#input\_enable\_oidc\_openid\_connect) | (Optional) Enable or disable OIDC OpenId Connect | `bool` | `false` | no |
| <a name="input_kube_proxy_addon_version"></a> [kube\_proxy\_addon\_version](#input\_kube\_proxy\_addon\_version) | (Optional) Specify the Add-ons version or use null for default value to use | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required)  The location in which the resources will be provisioned. | `any` | `null` | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | (Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire | `number` | `7` | no |
| <a name="input_map_role"></a> [map\_role](#input\_map\_role) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_map_user"></a> [map\_user](#input\_map\_user) | Additional IAM users to add to `config-map-aws-auth` ConfigMap | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_node_ami_type"></a> [node\_ami\_type](#input\_node\_ami\_type) | (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values: AL2\_x86\_64, AL2\_x86\_64\_GPU, AL2\_ARM\_64, CUSTOM, BOTTLEROCKET\_ARM\_64, BOTTLEROCKET\_x86\_64 | `string` | `"AL2_x86_64"` | no |
| <a name="input_node_capacity_type"></a> [node\_capacity\_type](#input\_node\_capacity\_type) | (Optional) Type of capacity associated with the EKS Node Group. Valid values: ON\_DEMAND, SPOT. | `string` | `"ON_DEMAND"` | no |
| <a name="input_node_desired_size"></a> [node\_desired\_size](#input\_node\_desired\_size) | (Required) Desired number of worker nodes. | `number` | `1` | no |
| <a name="input_node_disk_size"></a> [node\_disk\_size](#input\_node\_disk\_size) | (Optional) Disk size in GiB for worker nodes | `number` | `50` | no |
| <a name="input_node_ec2_ssh_key"></a> [node\_ec2\_ssh\_key](#input\_node\_ec2\_ssh\_key) | (Optional) EC2 Key Pair name that provides access for SSH communication with the worker nodes in the EKS Node Group. If you specify this configuration, but do not specify source\_security\_group\_ids when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0). | `string` | `null` | no |
| <a name="input_node_instance_types"></a> [node\_instance\_types](#input\_node\_instance\_types) | (Optional) List of instance types associated with the EKS Node Group. | `list(string)` | <pre>[<br>  "t2.xlarge"<br>]</pre> | no |
| <a name="input_node_max_size"></a> [node\_max\_size](#input\_node\_max\_size) | (Required) Maximum number of worker nodes. | `number` | `1` | no |
| <a name="input_node_max_unavailable"></a> [node\_max\_unavailable](#input\_node\_max\_unavailable) | (Optional) Desired max number of unavailable worker nodes during node group update. | `number` | `1` | no |
| <a name="input_node_min_size"></a> [node\_min\_size](#input\_node\_min\_size) | (Required) Minimum number of worker nodes | `number` | `1` | no |
| <a name="input_node_source_security_group_ids"></a> [node\_source\_security\_group\_ids](#input\_node\_source\_security\_group\_ids) | (Optional) Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes. If you specify ec2\_ssh\_key, but do not specify this configuration when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0) | `list(string)` | `null` | no |
| <a name="input_service_ipv4_cidr"></a> [service\_ipv4\_cidr](#input\_service\_ipv4\_cidr) | must be within 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16 | `string` | `"172.30.0.0/16"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet id's | `list(string)` | `null` | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `null` | no |
| <a name="input_vpc_cni_addon_version"></a> [vpc\_cni\_addon\_version](#input\_vpc\_cni\_addon\_version) | (Optional) Specify the Add-ons version or use null for default value to use | `string` | `null` | no |

## Outputs
| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | ARN of Cloudwatch log group |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of Cloudwatch log group |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the eks cluster |
| <a name="output_eks_cluster"></a> [eks\_cluster](#output\_eks\_cluster) | Details of eks cluster |
| <a name="output_eks_cluster_version"></a> [eks\_cluster\_version](#output\_eks\_cluster\_version) | The Kubernetes server version of the cluster |

### Additional Information

### Helpful Links
[docs.aws.amazon.com/eks/](https://docs.aws.amazon.com/eks/)

## License
[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

