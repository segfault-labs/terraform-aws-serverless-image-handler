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
  default = "Yes"
}

variable "cors_origin" {
  type    = string
  default = "*"
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
  type = object({
    create_log_group            = optional(bool, true)
    destination_arn             = optional(string)
    format                      = optional(string)
    log_group_name              = optional(string)
    log_group_retention_in_days = optional(number, 1)
    log_group_kms_key_id        = optional(string)
    log_group_skip_destroy      = optional(bool)
    log_group_class             = optional(string)
    log_group_tags              = optional(map(string), {})
  })
  default = { create_log_group = false }
}

variable "authorizers" {
  type    = any
  default = {}
}

variable "lambda_auto_webp" {
  type    = string
  default = "No"
}

variable "lambda_enable_signature" {
  type    = string
  default = "No"
}

variable "lambda_enable_default_fallback_image" {
  type    = string
  default = ""
}

variable "lambda_default_fallback_image_key" {
  type    = string
  default = "No"
}

variable "secrets_manager" {
  type    = string
  default = ""
}

variable "secret_key" {
  type    = string
  default = ""
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
