output "deployment_invoke_url" {
  value = aws_api_gateway_deployment.this.invoke_url
}

output "stage_invoke_url" {
  value = aws_api_gateway_stage.this.invoke_url
}

output "stage_domain_name" {
  value = split("/", replace(aws_api_gateway_stage.this.invoke_url, "https://", ""))[0]
}

output "api_execution_arn" {
  value = aws_api_gateway_rest_api.this.arn
}
