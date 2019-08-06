resource "aws_sns_topic" "default" {
  name      = "${var.topic_name}"
  provider  = "aws.us-east-1"
  
 provisioner "local-exec" {
   command = "aws sns subscribe --topic-arn ${self.arn} --region us-east-1 --protocol email --notification-endpoint ${var.sns-subscribe-list}"
 }
}
