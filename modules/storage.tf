# Variables
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# S3 Input Bucket
resource "aws_s3_bucket" "input" {
  bucket = "${var.project_name}-input-${var.environment}"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "input" {
  bucket = aws_s3_bucket.input.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "input" {
  bucket = aws_s3_bucket.input.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Output Bucket
resource "aws_s3_bucket" "output" {
  bucket = "${var.project_name}-output-${var.environment}"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "output" {
  bucket = aws_s3_bucket.output.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "output" {
  bucket = aws_s3_bucket.output.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# CORS Rule for Output Bucket (if needed for web access)
resource "aws_s3_bucket_cors_configuration" "output" {
  bucket = aws_s3_bucket.output.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"] # Restrinja isto em produção
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# DynamoDB Table
resource "aws_dynamodb_table" "video_processing" {
  name           = "${var.project_name}-processing-status-${var.environment}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  range_key      = "video_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "video_id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

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