resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}-dlq"

  tags = {
    Environment = var.environment
    Purpose     = "dead-letter"
  }
}

resource "aws_sqs_queue" "main" {
  name = var.queue_name

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })

  tags = {
    Environment = var.environment
    Purpose     = "primary"
  }
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  count     = var.sns_topic_arn != null ? 1 : 0
  topic_arn = var.sns_topic_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.main.arn

  # Required to allow delivery
  raw_message_delivery = true
}

resource "aws_sqs_queue_policy" "allow_sns" {
  count = var.sns_topic_arn != null ? 1 : 0

  queue_url = aws_sqs_queue.main.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Allow-SNS-SendMessage"
        Effect    = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.main.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = var.sns_topic_arn
          }
        }
      }
    ]
  })
}
