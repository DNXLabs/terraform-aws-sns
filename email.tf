resource "aws_sns_topic_subscription" "alarm_email" {
  count     = var.email != "" ? 1 : 0
  topic_arn = aws_sns_topic.default[0].arn
  protocol  = "email"
  endpoint  = var.email
}