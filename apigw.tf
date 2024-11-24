resource "aws_lambda_permission" "gateway_invokes_bulk_metadata_get_lambda" {
  function_name = module.lambda_function.lambda_function_arn
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.api_execution_arn}/*/*/*"
}

module "api_gateway_acm" {
  count = var.apigw_custom_domain_name != null ? 1 : 0

  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  domain_name = var.apigw_custom_domain_name
  zone_id     = var.apigw_dns_zone_id

  validation_method = "DNS"

  wait_for_validation = true

  tags = {
    Name = var.apigw_custom_domain_name
  }
}

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "5.2.0"

  name          = var.name
  protocol_type = "HTTP"

  domain_name = var.apigw_custom_domain_name

  stage_access_log_settings = var.stage_access_log_settings
  authorizers               = var.authorizers

  routes = {
    "ANY /{proxy+}" = {
      integration = {
        uri                    = "arn:aws:lambda:eu-west-1:052235179155:function:my-function"
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
  }
}

