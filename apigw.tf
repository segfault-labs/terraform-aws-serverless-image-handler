resource "aws_lambda_permission" "gateway_invokes_bulk_metadata_get_lambda" {
  function_name = module.lambda_function.lambda_function_arn
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.api_execution_arn}/*/*/{proxy+}"
}

module "api_gateway_acm" {
  count = var.apigw_custom_domain_name == "" ? 0 : 1

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
  source = "./modules/api_gateway"

  name              = var.name
  lambda_invoke_arn = module.lambda_function.lambda_function_arn
}

