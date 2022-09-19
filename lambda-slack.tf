resource "aws_iam_role" "default" {
  count = var.slack_endpoint == "" ? 0 : 1

  name_prefix = "slack-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "default" {
  count = var.slack_endpoint == "" ? 0 : 1

  name_prefix = "cloudwatchfull-lambda"
  path        = "/"
  description = "IAM policy for a lambda function"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:CreateLogGroup",
        "cloudwatch:*"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*",
        "arn:aws:cloudwatch:*:*:*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  count = var.slack_endpoint == "" ? 0 : 1

  role       = aws_iam_role.default[0].name
  policy_arn = aws_iam_policy.default[0].arn
}

resource "random_string" "lambda_suffix" {
  length  = 8
  special = false
  lower   = true
  number  = false
}

resource "aws_lambda_function" "default" {
  count = var.slack_endpoint == "" ? 0 : 1

  filename      = "${path.module}/slack.zip"
  function_name = "slack-cloudwatch-notification-${var.sns_topic_name != "" ? var.sns_topic_name : random_string.lambda_suffix.result}"
  role          = aws_iam_role.default[0].arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256("${path.module}/slack.zip")

  runtime = "nodejs16.x"

  environment {
    variables = {
      UNENCRYPTED_HOOK_URL = var.slack_endpoint
    }
  }
}

resource "aws_lambda_permission" "with_sns" {
  count = var.slack_endpoint == "" ? 0 : 1

  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default[0].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn != "" ? var.sns_topic_arn : aws_sns_topic.default[0].arn
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  count = var.slack_endpoint == "" ? 0 : 1

  #topic_arn = data.aws_sns_topic.health_topic_client.arn
  #endpoint  = data.aws_lambda_function.slack-lambda-function.arn
  topic_arn  = var.sns_topic_arn != "" ? var.sns_topic_arn : aws_sns_topic.default[0].arn
  protocol   = "lambda"
  endpoint   = aws_lambda_function.default[0].arn
  depends_on = [aws_lambda_function.default]
}
