output "main_queue_url" {
  description = "The URL of the main SQS queue"
  value       = aws_sqs_queue.main.id
}

output "main_queue_arn" {
  description = "The ARN of the main SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "dlq_arn" {
  description = "The ARN of the dead letter queue"
  value       = aws_sqs_queue.dlq.arn
}
