# AWS Key Management Service (KMS) Terraform module
![status](https://img.shields.io/badge/Status-approved%20(2022--07--14)-success)


AWS Key Management Service (KMS) gives you centralized control over the cryptographic keys used to protect your data. The service is integrated with other AWS services making it easy to encrypt data you store in these services and control access to the keys that decrypt it.

AWS KMS integrates with AWS services to encrypt data at rest, or to facilitate signing and verification using an AWS KMS key. To protect data at rest, integrated AWS services use envelope encryption, where a data key is used to encrypt data, and is itself encrypted under a KMS key stored in AWS KMS. For signing and verification, integrated AWS services use a key pair from an asymmetric KMS key in AWS KMS. 

The KMS keys you create or ones that are created on your behalf by other AWS services cannot be exported from the service. Therefore AWS KMS takes responsibility for their durability. To help ensure that your keys and your data is highly available, it stores multiple copies of encrypted versions of your keys in systems that are designed for 99.999999999% durability.

For encrypted data or digital signature workflows that move across Regions (disaster recovery, multi-Region high availability architectures, DynamoDB Global Tables, and globally distributed consistent digital signatures), you can create KMS multi-Region keys, a set of interoperable keys with the same key material and key IDs that can be replicated into multiple Regions.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```


## Examples


```hcl
module "kms_key" {
  source   = "../terraform_modules/aws/kms"
  location = "eu-west-1"
  enable_kms_encryption   = false
  description             = "KMS key for Project X"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = "alias/projectX"
  multi_region            = false
}
```


## Providers

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.20 |

## Modules
No modules.


## Resources
| Name | Type |
|------|------|
| [kms_alias](#aws_kms_alias.aws_kms_alias) | resource |
| [kms_key](#aws_kms_key) | resource |


## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `"Parameter Store KMS master key"` | no |
| [alias](#input\_alias) | The display name of the alias. The name must start with the word `alias` followed by a forward slash. If not specified, the alias name will be auto-generated. | `string` | `""` | no |
| [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource | `number` | `10` | no |
| [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `true` | no |
| [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `false` | no |
| [policy](#input\_policy) | A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. | `string` | `""` | no |
| [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. | `string` | `"ENCRYPT_DECRYPT"` | no |
| [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `true` | no |
| [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `false` | no |


## Outputs

| Name | Description |
|------|-------------|
| [alias\_arn](#output\_alias\_arn) | Alias ARN |
| [alias\_name](#output\_alias\_name) | Alias name |
| [key\_arn](#output\_key\_arn) | Key ARN |
| [key\_id](#output\_key\_id) | Key ID |

### Additional Information
### Helpful Links
