variable "queue_name" {
  description = "The name of the primary SQS queue"
  type        = string
}

variable "sns_topic_arn" {
  description = "Optional SNS topic ARN to subscribe the queue to"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment tag for resource grouping"
  type        = string
  default     = "martian"
}
