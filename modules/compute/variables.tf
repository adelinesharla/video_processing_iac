# Variables
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "lambda_bucket" {
  description = "S3 bucket containing Lambda artifacts"
  type        = string
}

variable "input_bucket" {
  description = "Input S3 bucket ID"
  type        = string
}

variable "output_bucket" {
  description = "Output S3 bucket ID"
  type        = string
}

variable "sqs_queue_url" {
  description = "SQS queue URL"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table name"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda functions"
  type        = string
}