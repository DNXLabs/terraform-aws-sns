resource "aws_sns_topic" "default" {
  name = "${var.topic_name}"
  
  # provisioner "local-exec" {
  #   command = "aws sns subscribe --topic-arn ${self.arn} --region ${data.aws_region.current.name} --protocol email --notification-endpoint ${var.sns_subscribe_list}"
  # }
}