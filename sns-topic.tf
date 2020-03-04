resource "aws_sns_topic" "default" {
  name = var.topic_name

  # provisioner "local-exec" {
  #   command = "aws sns subscribe --topic-arn ${self.arn} --region ${data.aws_region.current.name} --protocol email --notification-endpoint ${var.sns_subscribe_list}"
  # }
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.default.arn

  policy = data.aws_iam_policy_document.sns.json
}

data "aws_iam_policy_document" "sns" {
  policy_id = "allow-publish-clients"

  statement {
    actions = [
      "SNS:Publish"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = var.account_ids
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.default.arn,
    ]

    sid = "allow-publish-clients-stmt"
  }
}
