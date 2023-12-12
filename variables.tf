variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket Name to modify notification of"
}

variable "lambda_arn" {
  type        = string
  description = "Lambda ARN to be triggered with notification"
}

variable "events" {
  type        = list(string)
  description = "Which events should trigger the lambda"
}

variable "prefix" {
  type        = string
  description = "Prefix filter for files"
}

variable "suffix" {
  type        = string
  description = "Suffix filter for files"
}

variable "notification_id" {
  type        = string
  description = "ID of the notification declaration"
}
