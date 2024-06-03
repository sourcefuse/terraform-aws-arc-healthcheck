output "sns_arn" {
  value       = aws_sns_topic.this.arn
  description = "SNS ARN"
}

output "cloudwatch_alarm_arn" {
  value       = var.enable_alarm ? aws_cloudwatch_metric_alarm.ok[0].arn : ""
  description = "Cloudwatch Alarm ARN"
}

output "route53_health_check_arn" {
  value       = aws_route53_health_check.this.arn
  description = "Route53 Health check ARN"
}
