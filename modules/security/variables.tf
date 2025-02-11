# Variables
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "input_bucket_arn" {
  description = "Input S3 bucket ARN"
  type        = string
}

variable "output_bucket_arn" {
  description = "Output S3 bucket ARN"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  type        = string
}

variable "sqs_queue_arn" {
  description = "SQS queue ARN"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  type        = string
}