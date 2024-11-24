locals {
  lambda_function_policies = [
    aws_iam_policy.lambda_function.arn,
  ]
}

data "aws_iam_policy_document" "lambda_function" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:eu-central-1:767397850354:log-group:/aws/lambda/*",
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${data.aws_s3_bucket.bucket.arn}/*"
    ]
  }
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      data.aws_s3_bucket.bucket.arn
    ]
  }
  dynamic "statement" {
    for_each = var.lambda_default_fallback_image_key == null ? [] : [1]
    content {
      actions = [
        "s3:GetObject",
      ]
      resources = [
        "${data.aws_s3_bucket.bucket.arn}/${var.lambda_default_fallback_image_key}",
      ]
    }
  }
}

resource "aws_iam_policy" "lambda_function" {
  name   = "${var.name}-lambda-function"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_function.json
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.name

  handler     = "index.handler"
  runtime     = "nodejs20.x"
  memory_size = 1024

  attach_policies    = true
  number_of_policies = length(local.lambda_function_policies)
  policies           = local.lambda_function_policies

  s3_existing_package = {
    bucket = "solutions-${data.aws_region.current.name}"
    key    = "serverless-image-handler/v6.3.1/ec7210ae9c3270e222829ffafa69c8899b4806494ed2a55b41e3d51fe1829cf4.zip"
  }

  environment_variables = {
    SOURCE_BUCKETS = var.source_bucket

    CORS_ENABLED = var.cors_enabled
    CORS_ORIGIN  = var.cors_origin

    AUTO_WEBP                     = var.lambda_auto_webp
    ENABLE_SIGNATURE              = var.lambda_enable_signature
    ENABLE_DEFAULT_FALLBACK_IMAGE = var.lambda_enable_default_fallback_image
    DEFAULT_FALLBACK_IMAGE_BUCKET = var.source_bucket
    DEFAULT_FALLBACK_IMAGE_KEY    = var.lambda_default_fallback_image_key

    SECRETS_MANAGER = var.secrets_manager
    SECRET_KEY      = var.secret_key
  }
}
