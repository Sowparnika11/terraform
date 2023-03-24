AWS Secret Manager Terraform module
![status](https://img.shields.io/badge/Status-approved%20(2023--01--07)success)
Secrets Manager enables you to replace hardcoded credentials in your code, including passwords, with an API call to Secrets Manager to retrieve the secret programmatically. This helps ensure the secret can't be compromised by someone examining your code, because the secret no longer exists in the code. Also, you can configure Secrets Manager to automatically rotate the secret for you according to a specified schedule. This enables you to replace long-term secrets with short-term ones, significantly reducing the risk of compromise.

## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Examples
- Key/Value Secret
   ```hcl
   module "secret" {
    source               = "./code"
    region = "eu-west-2"
    secrets = {
      secret-1 = {
        description = "Another key/value secret"
        secret_key_value = {
          username = "user"
          password = "topsecret"
         }
        recovery_window_in_days = 7   
      }
    }
    tags = { Name      = "test"}
   }
   ```
- Plain Text Secret
   ```hcl
   module "secret" {
    source               = "./code"
    region = "eu-west-2"
    secrets = {
      secret-1 = {
        description             = "My secret 1"
        recovery_window_in_days = 7
        secret_string           = "XXXXXXXXXXXXXX"
      }
      secret-2 = {
      description             = "My secret 2"
      recovery_window_in_days = 7
      secret_string           = "XXXXXXXXXXXXXX"
      }
    }
    tags = { Name      = "test"}
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
| aws_secretsmanager_secret.secret_manager | Resource |
| aws_secretsmanager_secret_version.secret | Resource |


## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| region | location of the aws region | `string` | Null | Yes|
| tags | Specifies a key-value map of user-defined tags that are attached to the secret. | `any` | {} | No|
| recovery_window_in_days| Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. | `number` | 30 | Yes |
| secrets | Map of secrets to keep in AWS Secrets Manager| `any` | {} | Yes|

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)