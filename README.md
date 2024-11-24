<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0, < 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.77.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.77.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | n/a |
| <a name="module_api_gateway_acm"></a> [api\_gateway\_acm](#module\_api\_gateway\_acm) | terraform-aws-modules/acm/aws | 5.1.1 |
| <a name="module_cdn"></a> [cdn](#module\_cdn) | terraform-aws-modules/cloudfront/aws | 3.4.1 |
| <a name="module_cdn_acm"></a> [cdn\_acm](#module\_cdn\_acm) | terraform-aws-modules/acm/aws | 5.1.1 |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_lambda_permission.gateway_invokes_bulk_metadata_get_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_policy.allow_access_from_another_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apigw_custom_domain_name"></a> [apigw\_custom\_domain\_name](#input\_apigw\_custom\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_apigw_dns_zone_id"></a> [apigw\_dns\_zone\_id](#input\_apigw\_dns\_zone\_id) | n/a | `string` | `null` | no |
| <a name="input_authorizers"></a> [authorizers](#input\_authorizers) | n/a | `any` | `null` | no |
| <a name="input_cdn_custom_domain_name"></a> [cdn\_custom\_domain\_name](#input\_cdn\_custom\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_cdn_custom_domain_names"></a> [cdn\_custom\_domain\_names](#input\_cdn\_custom\_domain\_names) | n/a | `list(string)` | `[]` | no |
| <a name="input_cdn_direct_access_path_pattern"></a> [cdn\_direct\_access\_path\_pattern](#input\_cdn\_direct\_access\_path\_pattern) | n/a | `string` | `null` | no |
| <a name="input_cdn_dns_zone_id"></a> [cdn\_dns\_zone\_id](#input\_cdn\_dns\_zone\_id) | n/a | `string` | `null` | no |
| <a name="input_cdn_price_class"></a> [cdn\_price\_class](#input\_cdn\_price\_class) | n/a | `string` | `"PriceClass_100"` | no |
| <a name="input_cors_enabled"></a> [cors\_enabled](#input\_cors\_enabled) | n/a | `string` | `null` | no |
| <a name="input_cors_origin"></a> [cors\_origin](#input\_cors\_origin) | n/a | `string` | `null` | no |
| <a name="input_lambda_auto_webp"></a> [lambda\_auto\_webp](#input\_lambda\_auto\_webp) | n/a | `string` | `null` | no |
| <a name="input_lambda_default_fallback_image_key"></a> [lambda\_default\_fallback\_image\_key](#input\_lambda\_default\_fallback\_image\_key) | n/a | `string` | `null` | no |
| <a name="input_lambda_enable_default_fallback_image"></a> [lambda\_enable\_default\_fallback\_image](#input\_lambda\_enable\_default\_fallback\_image) | n/a | `string` | `null` | no |
| <a name="input_lambda_enable_signature"></a> [lambda\_enable\_signature](#input\_lambda\_enable\_signature) | n/a | `string` | `null` | no |
| <a name="input_log_bucket"></a> [log\_bucket](#input\_log\_bucket) | n/a | `string` | `null` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | n/a | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | n/a | `string` | `null` | no |
| <a name="input_secrets_manager"></a> [secrets\_manager](#input\_secrets\_manager) | n/a | `string` | `null` | no |
| <a name="input_source_bucket"></a> [source\_bucket](#input\_source\_bucket) | n/a | `string` | n/a | yes |
| <a name="input_source_bucket_policy"></a> [source\_bucket\_policy](#input\_source\_bucket\_policy) | n/a | `string` | `"{}"` | no |
| <a name="input_stage_access_log_settings"></a> [stage\_access\_log\_settings](#input\_stage\_access\_log\_settings) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cdn_domain_name"></a> [cdn\_domain\_name](#output\_cdn\_domain\_name) | n/a |
<!-- END_TF_DOCS -->