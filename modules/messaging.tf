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
  }
}

# SNS Topic
resource "aws_sns_topic" "notifications" {
  name = "${var.project_name}-notifications"
}