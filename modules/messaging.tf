# Variables
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# SQS Queue
resource "aws_sqs_queue" "video_processing" {
  name                      = "${var.project_name}-processing-queue"
  delay_seconds             = 0
  max_message_size         = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  visibility_timeout_seconds = 300
  
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# SQS Queue Policy
resource "aws_sqs_queue_policy" "video_processing" {
  queue_url = aws_sqs_queue.video_processing.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.video_processing.arn
      }
    ]
  })
}

# SNS Topic
resource "aws_sns_topic" "notifications" {
  name = "${var.project_name}-notifications"
  
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# SNS Topic Policy
resource "aws_sns_topic_policy" "notifications" {
  arn = aws_sns_topic.notifications.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sns:Publish"
        Resource = aws_sns_topic.notifications.arn
      }
    ]
  })
}

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