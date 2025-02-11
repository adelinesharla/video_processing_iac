# Variables
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_iam_role" {
  description = "ARN of the existing IAM role to use"
  type        = string
  default     = "arn:aws:iam::717145188069:role/LabRole"
}