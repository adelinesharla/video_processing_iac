output "api_endpoint" {
  value       = module.api.api_endpoint
  description = "API Gateway endpoint URL"
}

output "cognito_user_pool_id" {
  value       = module.security.cognito_user_pool_id
  description = "Cognito User Pool ID"
}

output "cognito_client_id" {
  value       = module.security.cognito_client_id
  description = "Cognito Client ID"
}

output "input_bucket" {
  value       = module.storage.input_bucket_id
  description = "Input S3 bucket name"
}

output "output_bucket" {
  value       = module.storage.output_bucket_id
  description = "Output S3 bucket name"
}

output "dynamodb_table" {
  value       = module.storage.dynamodb_table_name
  description = "DynamoDB table name"
}

output "sqs_queue_url" {
  value       = module.messaging.sqs_queue_url
  description = "SQS queue URL"
}

output "sns_topic_arn" {
  value       = module.messaging.sns_topic_arn
  description = "SNS topic ARN"
}