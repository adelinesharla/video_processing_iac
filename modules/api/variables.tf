variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cognito_user_pool" {
  description = "Cognito User Pool ID"
  type        = string
}

variable "upload_lambda_arn" {
  description = "Upload Lambda function ARN"
  type        = string
}