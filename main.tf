terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Storage Module (S3 and DynamoDB)
module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
  environment  = var.environment
}

# Messaging Module (SQS and SNS)
module "messaging" {
  source = "./modules/messaging"

  project_name = var.project_name
  environment  = var.environment
}

# Security Module (Cognito)
module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment
  aws_iam_role = var.aws_iam_role
}

# Compute Module (Lambda Functions)
module "compute" {
  source = "./modules/compute"

  project_name  = var.project_name
  environment   = var.environment
  lambda_bucket = var.lambda_bucket

  # Pass resource information from other modules
  input_bucket    = module.storage.input_bucket_id
  output_bucket   = module.storage.output_bucket_id
  sqs_queue_url   = module.messaging.sqs_queue_url
  sns_topic_arn   = module.messaging.sns_topic_arn
  dynamodb_table  = module.storage.dynamodb_table_name
  lambda_role_arn = var.aws_iam_role

  depends_on = [
    module.storage,
    module.messaging,
    module.security
  ]
}

# API Module (API Gateway)
module "api" {
  source = "./modules/api"

  project_name          = var.project_name
  environment           = var.environment
  cognito_user_pool_arn = module.security.cognito_user_pool_arn
  upload_lambda_arn     = module.compute.upload_lambda_arn

  depends_on = [
    module.security,
    module.compute
  ]
}