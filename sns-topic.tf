resource "aws_sns_topic" "default" {
  name = var.topic_name

  # provisioner "local-exec" {
  #   command = "aws sns subscribe --topic-arn ${self.arn} --region ${data.aws_region.current.name} --protocol email --notification-endpoint ${var.sns_subscribe_list}"
  # }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.default.arn
  policy = length(var.account_ids) != 0 ? data.aws_iam_policy_document.sns[0].json : data.aws_iam_policy_document.sns_all[0].json
}

data "aws_iam_policy_document" "sns_all" {
  count = length(var.account_ids) != 0 ? 0 : 1

  policy_id = "allow-publish-clients"

  statement {
    actions = [
      "SNS:Publish"
    ]

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

data "aws_iam_policy_document" "sns" {
  count = length(var.account_ids) != 0 ? 1 : 0

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
