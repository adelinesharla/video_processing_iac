variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

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

variable "aws_iam_role" {
  description = "ARN of the existing IAM role to use"
  type        = string
  default     = "arn:aws:iam::738118156289:role/LabRole"
}