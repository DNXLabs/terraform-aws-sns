resource "aws_iam_role" "default" {
  name = "slack-lambda"

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
  name = "cloudwatchfull-lambda"
  path = "/"
  description = "IAM policy for a lambda function"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
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
  role = "${aws_iam_role.default.name}"
  policy_arn = "${aws_iam_policy.default.arn}"
}


resource "aws_lambda_function" "default" {

  provider = "aws.us-east-1"
  
  filename      = "slack.zip"
  function_name = "Slack-notification-healthcheck"
  role          = "${aws_iam_role.default.arn}"
  
  
  handler       = "main"

  source_code_hash = "${filebase64sha256("${path.module}/slack.zip")}"

  runtime = "go1.x"

  environment {
    variables = {
      SLACK_WEBHOOK = "${var.slack_endpoint}"
    }
  }
}

resource "aws_lambda_permission" "with_sns" {
  provider = "aws.us-east-1"

  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.default.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.default.arn}"
}


resource "aws_sns_topic_subscription" "lambda_subscription" {
  provider      = "aws.us-east-1"
  #topic_arn     = "${data.aws_sns_topic.health_topic_client.arn}"
  topic_arn     = "${aws_sns_topic.default.arn}"
  protocol      = "lambda"
  #endpoint      = "${data.aws_lambda_function.slack-lambda-function.arn}"
  endpoint      = "${aws_lambda_function.default.arn}"

  depends_on    = ["aws_lambda_function.default"]

}
