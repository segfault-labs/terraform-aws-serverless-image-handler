resource "aws_api_gateway_rest_api" "this" {
  name = var.name

  api_key_source     = "HEADER"
  binary_media_types = ["*/*"]
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  minimum_compression_size = -1
}

resource "aws_api_gateway_resource" "parent" {
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "/"
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_resource" "this" {
  parent_id   = aws_api_gateway_resource.parent.id
  path_part   = "{proxy+}"
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_method" "any" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_resource.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.any.http_method
  passthrough_behavior    = "WHEN_NO_MATCH"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  timeout_milliseconds    = "29000"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_integration" "this_parent" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.parent.id
  http_method             = aws_api_gateway_method.any.http_method
  passthrough_behavior    = "WHEN_NO_MATCH"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  timeout_milliseconds    = "29000"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.this.id,
      aws_api_gateway_method.any.id,
      aws_api_gateway_integration.this.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "image"
}
