AWS Cloudfront Distribution Module
![status](https://img.shields.io/badge/Status-approved%20(2022--07--10)-success)

Amazon CloudFront is a web service that speeds up distribution of your static and dynamic web content, such as .html, .css, .js, and image files, to your users. CloudFront delivers your content through a worldwide network of data centers called edge locations. When a user requests content that you're serving with CloudFront, the request is routed to the edge location that provides the lowest latency (time delay), so that content is delivered with the best possible performance.


## Usage

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Examples
- With minimum parameters
  ```hcl
  module "cdn" {
    source = "./code"

    #aliases = ["cdn2.example.com"]

    comment             = "My awesome CloudFront"
    enabled             = true
    is_ipv6_enabled     = true
    price_class         = "PriceClass_All"
    retain_on_delete    = false
    wait_for_deployment = false
    web_acl_id          = "arn:aws:wafv2:us-east-1:834829128384:global/webacl/sow-webacl/cc4ce8b8-afdc-4adf-a228-14d022395277"

    create_origin_access_identity = true
    origin_access_identities = {
      s3_bucket_one = "My awesome CloudFront can access"
    }
    
    logging_config = {
      bucket = "sow3-one-logs.s3.amazonaws.com"
    }

    origin = {
      s3_one = {
        domain_name = "test-sow3.s3.amazonaws.com"	  
        custom_origin_config = {
          http_port              = 80
          https_port             = 443
          origin_protocol_policy = "match-viewer"
          origin_ssl_protocols   = ["TLSv1.2"]
        }
      }
    }

    default_cache_behavior = {
      target_origin_id           = "s3_one"
      viewer_protocol_policy     = "redirect-to-https"#"allow-all"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
      # response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
    }
  }
  ```

- With all parameters
  ``` hcl
  module "cdn" {
    source = "./code"

    #aliases = ["cdn2.example.com"]

    comment             = "My awesome CloudFront"
    enabled             = true
    is_ipv6_enabled     = true
    price_class         = "PriceClass_All"
    retain_on_delete    = false
    wait_for_deployment = false
    web_acl_id          = "arn:aws:wafv2:us-east-1:834829128384:global/webacl/sow-webacl/cc4ce8b8-afdc-4adf-a228-14d022395277"
    create_distribution = true

    create_origin_access_identity = true
    origin_access_identities = {
      s3_bucket_one = "My awesome CloudFront can access"
    }
    
    logging_config = {
      bucket = "sow3-one-logs.s3.amazonaws.com"
    }

    origin = {
      s3_one = {
        domain_name = "test-sow3.s3.amazonaws.com"	  
        custom_origin_config = {
          http_port              = 80
          https_port             = 443
          origin_protocol_policy = "match-viewer"
          origin_ssl_protocols   = ["TLSv1.2"]
        }
      }
    }

    default_cache_behavior = {
      target_origin_id           = "s3_one"
      viewer_protocol_policy     = "redirect-to-https"#"allow-all"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
      # response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
    }

    ordered_cache_behavior = [
    {
      path_pattern           = "/test1/"
      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      target_origin_id       = "s3_one"
      compress               = false
      query_string           = true
      cookies_forward        = "all"
      headers                = []
      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      # response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
    },
    {
      path_pattern           = "/test2/"
      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      target_origin_id       = "s3_one"
      compress               = false
      query_string           = true
      cookies_forward        = "all"
      headers                = []
      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      # response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
    }
    ]
    create                   = true
    retention_in_days        = 7
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
| aws_cloudfront_origin_access_identity.Cloudfrontoai | Resource |
| aws_cloudfront_distribution.cdndistribution | Resource |
| aws_cloudwatch_log_group.cloudwatch_log_group| Resource |

## Input

| Name | Description | Type | Default | Required |
| --- | ------ | --- | --- | --- |
| location | location of the aws region | `string` | Null | Yes|
| create_distribution | Controls if CloudFront distribution should be created | `bool` | true | yes |
| origin_access_identities | Map of CloudFront origin access identities (value as a comment)| `map(string)` | {} | No |
| create_origin_access_identity | Controls if CloudFront origin access identity should be created | `bool` | false | No |
| aliases | Extra CNAMEs (alternate domain names), if any, for this distribution | `list(string)` | null | No |
| comment | Any comments you want to include about the distribution | `string` | Null | No |
| default_root_object | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `string` | Null | No |
| enabled | Whether the distribution is enabled to accept end user requests for content. | `bool` | true | No |
| http_version | The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2 | `string` | http2 | no |
| is_ipv6_enabled | Whether the IPv6 is enabled for the distribution. | `bool` | Null | Yes |
| price_class | The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100 | `string` | Null | no |
| retain_on_delete | Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. | `bool` | false | No |
| wait_for_deployment | If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. | `bool` | true | No |
| web_acl_id | If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. If using WAFv2, provide the ARN of the web ACL | `string` | Null | No |
| tags | A map of tags to assign to the resource | `map(string)` | Null | No |
| origin | One or more origins for this distribution (multiples allowed) | `any` | Null | No |
| viewer_certificate | The SSL configuration for this distribution | `any` | {cloudfront_default_certificate = true minimum_protocol_version       = "TLSv1.2_2018" } | No |
| geo_restriction | The restriction configuration for this distribution (geo_restrictions) | `any` | {} | No |
| custom_error_response | One or more custom error response elements | `any` | {} | No |
| default_cache_behavior | The default cache behavior for this distribution | `any` | Null | No |
| ordered_cache_behavior | Ordered Cache Behaviors to be used in dynamic block | `any` | null | No |
| logging_config | The logging configuration that controls how logs are written to your distribution (maximum one). | `any` | null | No |
| create | to decide whether cloud watch log for cloudfront needs to be created or not | `bool` | False | No |
| retention_in_days |Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire | `number` | 7 | No |

## License

[Mozilla Public License v2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE)
