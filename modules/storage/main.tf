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

