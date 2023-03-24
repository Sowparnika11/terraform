# Create Cloudfront distribution
module "cdn" {
  source = "./code"
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
  }
}


