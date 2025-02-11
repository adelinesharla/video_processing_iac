# Outputs
output "input_bucket_id" {
  description = "ID of the input S3 bucket"
  value       = aws_s3_bucket.input.id
}

output "input_bucket_arn" {
  description = "ARN of the input S3 bucket"
  value       = aws_s3_bucket.input.arn
}

output "output_bucket_id" {
  description = "ID of the output S3 bucket"
  value       = aws_s3_bucket.output.id
}

output "output_bucket_arn" {
  description = "ARN of the output S3 bucket"
  value       = aws_s3_bucket.output.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.video_processing.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.video_processing.arn
}

# Optional: Output the domain names if needed for CloudFront or other services
output "input_bucket_domain_name" {
  description = "Domain name of the input bucket"
  value       = aws_s3_bucket.input.bucket_regional_domain_name
}

output "output_bucket_domain_name" {
  description = "Domain name of the output bucket"
  value       = aws_s3_bucket.output.bucket_regional_domain_name
}