# Lambda Functions
resource "aws_lambda_function" "upload_handler" {
  filename         = "lambda/upload_handler.zip"
  function_name    = "${var.project_name}-upload-handler"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"

  environment {
    variables = {
      INPUT_BUCKET = aws_s3_bucket.input.id
      SQS_QUEUE_URL = aws_sqs_queue.video_processing.url
      DYNAMODB_TABLE = aws_dynamodb_table.video_processing.name
    }
  }
}

resource "aws_lambda_function" "video_processor" {
  filename         = "lambda/video_processor.zip"
  function_name    = "${var.project_name}-video-processor"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "python3.9"
  timeout         = 300
  memory_size     = 1024

  environment {
    variables = {
      INPUT_BUCKET = aws_s3_bucket.input.id
      OUTPUT_BUCKET = aws_s3_bucket.output.id
      SNS_TOPIC_ARN = aws_sns_topic.notifications.arn
      DYNAMODB_TABLE = aws_dynamodb_table.video_processing.name
    }
  }
}

resource "aws_lambda_function" "notification_handler" {
  filename         = "lambda/notification_handler.zip"
  function_name    = "${var.project_name}-notification-handler"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.notifications.arn
    }
  }
}