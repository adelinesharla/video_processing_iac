# S3 Buckets
resource "aws_s3_bucket" "input" {
  bucket = "${var.project_name}-input-${var.environment}"
}

resource "aws_s3_bucket" "output" {
  bucket = "${var.project_name}-output-${var.environment}"
}

# DynamoDB Table
resource "aws_dynamodb_table" "video_processing" {
  name           = "${var.project_name}-processing-status"
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

  tags = {
    Environment = var.environment
  }
}
