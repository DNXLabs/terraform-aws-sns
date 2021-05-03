#data "aws_sns_topic" "health_topic_client" {
#  provider      = "aws.us-east-1"
#  name          = "healthcheck-${var.name}"
#  depends_on    = ["aws_sns_topic.route53-healthcheck"]
#}
#
#data "aws_iam_role" "slack-lambda-role" {
#  name = "slack-lambda"
# # depends_on    = ["aws_iam_role.iam_for_lambda"]
#
#}
#
#
#data "aws_lambda_function" "slack-lambda-function" {
#  provider      = "aws.us-east-1"
#  function_name = "Slack-notification-healthcheck"
# # depends_on    = ["aws_lambda_function.slack-lambda"]
#
#}
#

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}