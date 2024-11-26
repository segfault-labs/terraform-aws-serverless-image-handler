data "aws_iam_policy_document" "s3_bucket_policy" {
  count = var.source_bucket_policy == "{}" ? 0 : 1
  override_policy_documents = [
    var.source_bucket_policy,
  ]

  statement {
    sid = "AllowCloudFrontServicePrincipalReadOnly"
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${data.aws_s3_bucket.bucket.arn}/*",
    ]

    principals {
      type = "Service"

      identifiers = [
        "cloudfront.amazonaws.com",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [module.cdn.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  count  = var.source_bucket_policy == "{}" ? 0 : 1
  bucket = data.aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.s3_bucket_policy[0].json
}

module "cdn_acm" {
  count = var.cdn_custom_domain_name == "" ? 0 : 1

  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  domain_name = var.cdn_custom_domain_name
  zone_id     = var.cdn_dns_zone_id

  validation_method = "DNS"

  subject_alternative_names = var.cdn_custom_domain_names

  wait_for_validation = true

  tags = {
    Name = var.cdn_custom_domain_name
  }
}

module "cdn" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.4.1"

  aliases = var.cdn_custom_domain_name == "" ? [] : distinct(concat([var.cdn_custom_domain_name], var.cdn_custom_domain_names))

  comment         = var.cdn_custom_domain_name
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  create_origin_access_identity = true
  origin_access_identities = {
    api_gateway = "CloudFront Access ${var.name} apigw"
    s3_bucket   = "CloudFront Access ${var.name} bucket"
  }

  logging_config = var.log_bucket == null ? {} : {
    bucket = var.log_bucket
  }

  origin = {
    api_gateway = {
      domain_name = module.api_gateway.stage_domain_name
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

    s3_bucket = {
      domain_name = data.aws_s3_bucket.bucket.bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "api_gateway"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = var.cdn_direct_access_path_pattern == null ? [] : [
    {
      path_pattern           = var.cdn_direct_access_path_pattern
      target_origin_id       = "s3_bucket"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]

  viewer_certificate = var.cdn_custom_domain_name == "" ? {} : {
    acm_certificate_arn = module.cdn_acm[0].acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}
