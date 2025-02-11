# Lambda Functions
resource "aws_lambda_function" "upload_handler" {
  filename         = "lambda/upload_handler.zip"
  function_name    = "${var.project_name}-upload-handler"
  role            = var.lambda_role_arn
  handler         = "main.handler"
  runtime         = "python3.9"

  environment {
    variables = {
      INPUT_BUCKET   = var.input_bucket
      SQS_QUEUE_URL  = var.sqs_queue_url
      DYNAMODB_TABLE = var.dynamodb_table
    }
  }
}

resource "aws_lambda_function" "video_processor" {
  filename         = "lambda/video_processor.zip"
  function_name    = "${var.project_name}-video-processor"
  role            = var.lambda_role_arn
  handler         = "main.handler"
  runtime         = "python3.9"
  timeout         = 300
  memory_size     = 1024

  environment {
    variables = {
      INPUT_BUCKET    = var.input_bucket
      OUTPUT_BUCKET   = var.output_bucket
      SNS_TOPIC_ARN   = var.sns_topic_arn
      DYNAMODB_TABLE  = var.dynamodb_table
    }
  }
}

resource "aws_lambda_function" "notification_handler" {
  filename         = "lambda/notification_handler.zip"
  function_name    = "${var.project_name}-notification-handler"
  role            = var.lambda_role_arn
  handler         = "main.handler"
  runtime         = "python3.9"

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

# Lambda Permissions
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.upload_handler.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "sqs" {
  statement_id  = "AllowSQSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.video_processor.function_name
  principal     = "sqs.amazonaws.com"
}

resource "aws_lambda_permission" "sns" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notification_handler.function_name
  principal     = "sns.amazonaws.com"
}