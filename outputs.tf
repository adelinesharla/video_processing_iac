output "api_endpoint" {
  value = aws_api_gateway_rest_api.main.execution_arn
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.main.id
}

output "input_bucket" {
  value = aws_s3_bucket.input.id
}

output "output_bucket" {
  value = aws_s3_bucket.output.id
}