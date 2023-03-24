# AWS ECR Terraform module
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

<br />
Amazon Elastic Container Registry (Amazon ECR) is an AWS managed container image registry service that is secure, scalable, and reliable. Amazon ECR supports private repositories with resource-based permissions using AWS IAM. This is so that specified users or Amazon EC2 instances can access your container repositories and images.

<br />

### Features of Amazon ECR


**Lifecycle policies** help with managing the lifecycle of the images in your repositories. For more information, see [Lifecycle policies](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html).

**Image scanning** helps in identifying software vulnerabilities in your container images. Each repository can be configured to scan on push. This ensures that each new image pushed to the repository is scanned. You can then retrieve the results of the image scan. For more information, see [Image scanning](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html).

<br />

### Components of Amazon ECR


**Registry** An Amazon ECR private registry is provided to each AWS account; you can create one or more repositories in your registry and store images in them. For more information, see Amazon [ECR private registry](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html).

***Authorization token*** Your client must authenticate to Amazon ECR registries as an AWS user before it can push and pull images. For more information, see [Private registry authentication](https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry_auth.html).

**Repository** An Amazon ECR repository contains your Docker images, Open Container Initiative (OCI) images, and OCI compatible artifacts.

**Repository policy** You can control access to your repositories and the images within them with repository policies. For more information, see [Private repository policies](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Repositories.html).

**Image** You can push and pull container images to your repositories. You can use these images locally on your development system, or you can use them in Amazon ECS task definitions and Amazon EKS pod specifications. For more information, see [Using Amazon ECR images with Amazon ECS](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_on_ECS.html) and [Using Amazon ECR Images with Amazon EKS](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_on_EKS.html).

<br /><br />

## Usage


```bash
$ terraform init
$ terraform plan
$ terraform apply
```


## Examples
```hcl
module "ecr" {
  create_repository                      = true
  source                                 = "../terraform_modules/aws/ecr"
  location                               = "eu-west-1"
  repository_name                        = "temp-repo"
  manage_registry_scanning_configuration = true
  registry_scan_type                     = "ENHANCED"
  #repository_kms_key             = "arn:aws:kms:eu-west-1:834829128384:key/08b33490-0b36-4976-84a1-7a21853e1823"
  registry_scan_rules = [
    {
      scan_frequency = "SCAN_ON_PUSH"
      filter         = "*"
      filter_type    = "WILDCARD"
      }, {
      scan_frequency = "CONTINUOUS_SCAN"
      filter         = "example"
      filter_type    = "WILDCARD"
    }
  ]

  create_registry_policy = true
  registry_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "testpolicy",
        Effect = "Allow",
        Principal = {
        "AWS" : "arn:aws:iam::834829128384:user/abhilash" },
        Action = [
          "ecr:DescribeImages",
          "ecr:DescribeRepositories"
        ],
        Resource = [
          "arn:aws:ecr:eu-west-1:834829128384:repository/*"
        ]

      }
    ]
  })
  create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22 |


## Modules
No modules.


## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy] | resource |
| [aws_ecr_pull_through_cache_rule] | resource |
| [aws_ecr_registry_policy] | resource |
| [aws_ecr_registry_scanning_configuration] | resource |
| [aws_ecr_replication_configuration] | resource |
| [aws_ecr_repository] | resource |
| [aws_ecr_repository_policy] | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [attach\_repository\_policy](#input\_attach\_repository\_policy) | Determines whether a repository policy will be attached to the repository | `bool` | `true` | no |
| [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| [create\_lifecycle\_policy](#input\_create\_lifecycle\_policy) | Determines whether a lifecycle policy will be created | `bool` | `true` | no |
| [create\_registry\_policy](#input\_create\_registry\_policy) | Determines whether a registry policy will be created | `bool` | `false` | no |
| [create\_registry\_replication\_configuration](#input\_create\_registry\_replication\_configuration) | Determines whether a registry replication configuration will be created | `bool` | `false` | no |
| [create\_repository](#input\_create\_repository) | Determines whether a repository will be created | `bool` | `true` | no |
| [create\_repository\_policy](#input\_create\_repository\_policy) | Determines whether a repository policy will be created | `bool` | `true` | no |
| [manage\_registry\_scanning\_configuration](#input\_manage\_registry\_scanning\_configuration) | Determines whether the registry scanning configuration will be managed | `bool` | `false` | no |
| [registry\_policy](#input\_registry\_policy) | The policy document. This is a JSON formatted string | `string` | `null` | no |
| [registry\_pull\_through\_cache\_rules](#input\_registry\_pull\_through\_cache\_rules) | List of pull through cache rules to create | `map(map(string))` | `{}` | no |
| [registry\_replication\_rules](#input\_registry\_replication\_rules) | The replication rules for a replication configuration. A maximum of 10 are allowed | `any` | `[]` | no |
| [registry\_scan\_rules](#input\_registry\_scan\_rules) | One or multiple blocks specifying scanning rules to determine which repository filters are used and at what frequency scanning will occur | `any` | `[]` | no |
| [registry\_scan\_type](#input\_registry\_scan\_type) | the scanning type to set for the registry. Can be either `ENHANCED` or `BASIC` | `string` | `"ENHANCED"` | no |
| [repository\_encryption\_type](#input\_repository\_encryption\_type) | The encryption type for the repository. Must be one of: `KMS` or `AES256`. Defaults to `AES256` | `string` | `null` | no |
| [repository\_force\_delete](#input\_repository\_force\_delete) | If `true`, will delete the repository even if it contains images. Defaults to `false` | `bool` | `null` | no |
| [repository\_image\_scan\_on\_push](#input\_repository\_image\_scan\_on\_push) | Indicates whether images are scanned after being pushed to the repository (`true`) or not scanned (`false`) | `bool` | `true` | no |
| [repository\_image\_tag\_mutability](#input\_repository\_image\_tag\_mutability) | The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`. Defaults to `IMMUTABLE` | `string` | `"IMMUTABLE"` | no |
| [repository\_kms\_key](#input\_repository\_kms\_key) | The ARN of the KMS key to use when encryption\_type is `KMS`. If not specified, uses the default AWS managed key for ECR | `string` | `null` | no |
| [repository\_lifecycle\_policy](#input\_repository\_lifecycle\_policy) | The policy document. This is a JSON formatted string. See more details about [Policy Parameters](http://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html#lifecycle_policy_parameters) in the official AWS docs | `string` | `""` | no |
| [repository\_name](#input\_repository\_name) | The name of the repository | `string` | `""` | no |
| [repository\_policy](#input\_repository\_policy) | The JSON policy to apply to the repository. If not specified, uses the default policy | `string` | `null` | no |
| [repository\_read\_access\_arns](#input\_repository\_read\_access\_arns) | The ARNs of the IAM users/roles that have read access to the repository | `list(string)` | `[]` | no |
| [repository\_read\_write\_access\_arns](#input\_repository\_read\_write\_access\_arns) | The ARNs of the IAM users/roles that have read/write access to the repository | `list(string)` | `[]` | no |
| [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
|[repository\_arn](#output\_repository\_arn) | Full ARN of the repository |
|[repository\_registry\_id](#output\_repository\_registry\_id) | The registry ID where the repository was created |
|[repository\_url](#output\_repository\_url) | The URL of the repository |

### Additional Information


## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)

### Additional Information

### Helpful Links
[docs.aws.amazon.com/ecr](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)