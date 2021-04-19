output "aws_sns_topic_arn" {
  value = try(aws_sns_topic.default[0].arn, "")
}
