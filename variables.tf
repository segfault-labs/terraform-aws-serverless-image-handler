variable "name" {
  type = string
}

variable "source_bucket" {
  type = string
}

variable "source_bucket_policy" {
  type    = string
  default = "{}"
}

variable "cors_enabled" {
  type    = string
  default = null
}

variable "cors_origin" {
  type    = string
  default = null
}

variable "log_bucket" {
  type    = string
  default = null
}

variable "log_retention" {
  type    = number
  default = 1
}

variable "stage_access_log_settings" {
  type    = any
  default = null
}

variable "authorizers" {
  type    = any
  default = null
}

variable "lambda_auto_webp" {
  type    = string
  default = null
}

variable "lambda_enable_signature" {
  type    = string
  default = null
}

variable "lambda_enable_default_fallback_image" {
  type    = string
  default = null
}

variable "lambda_default_fallback_image_key" {
  type    = string
  default = null
}

variable "secrets_manager" {
  type    = string
  default = null
}

variable "secret_key" {
  type    = string
  default = null
}

variable "apigw_custom_domain_name" {
  type    = string
  default = null
}

variable "apigw_dns_zone_id" {
  type    = string
  default = null
}

variable "cdn_price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "cdn_custom_domain_name" {
  type    = string
  default = null
}

variable "cdn_custom_domain_names" {
  type    = list(string)
  default = []
}

variable "cdn_dns_zone_id" {
  type    = string
  default = null
}

variable "cdn_direct_access_path_pattern" {
  type    = string
  default = null
}
