output "cdn_domain_name" {
  value = module.cdn.cloudfront_distribution_domain_name
}

output "cloudfront_arn" {
  value = module.cdn.cloudfront_distribution_arn
}
