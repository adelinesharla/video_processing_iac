# Outputs
output "sqs_queue_url" {
  description = "URL of the SQS queue for video processing"
  value       = aws_sqs_queue.video_processing.url
}

output "sqs_queue_arn" {
  description = "ARN of the SQS queue for video processing"
  value       = aws_sqs_queue.video_processing.arn
}

output "sqs_queue_name" {
  description = "Name of the SQS queue for video processing"
  value       = aws_sqs_queue.video_processing.name
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for notifications"
  value       = aws_sns_topic.notifications.arn
}

output "sns_topic_name" {
  description = "Name of the SNS topic for notifications"
  value       = aws_sns_topic.notifications.name
}