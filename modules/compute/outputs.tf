# Outputs
output "upload_lambda_arn" {
  description = "ARN of the upload handler Lambda function"
  value       = aws_lambda_function.upload_handler.arn
}

output "upload_lambda_function_name" {
  description = "Name of the upload handler Lambda function"
  value       = aws_lambda_function.upload_handler.function_name
}

output "video_processor_arn" {
  description = "ARN of the video processor Lambda function"
  value       = aws_lambda_function.video_processor.arn
}

output "video_processor_function_name" {
  description = "Name of the video processor Lambda function"
  value       = aws_lambda_function.video_processor.function_name
}

output "notification_handler_arn" {
  description = "ARN of the notification handler Lambda function"
  value       = aws_lambda_function.notification_handler.arn
}

output "notification_handler_function_name" {
  description = "Name of the notification handler Lambda function"
  value       = aws_lambda_function.notification_handler.function_name
}