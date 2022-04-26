resource "aws_sns_topic" "user-updates" {
    name = "update_topic" 
}


resource "aws_sns_topic_subscription" "notification-topic" {
    topic_arn = aws_sns_topic.user-updates.arn
    protocol = "email"
    endpoint = "${var.endpoint-email}"
}