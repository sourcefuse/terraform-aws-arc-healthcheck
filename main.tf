resource "aws_route53_health_check" "this" {
  fqdn              = var.domain_name
  port              = var.port
  type              = var.type
  resource_path     = var.resource_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval
  search_string     = var.search_string
  measure_latency   = var.measure_latency
  tags = merge(
    {
      Name = var.name
    },
  var.tags)
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.alarm_prefix}-${var.domain_name}${var.resource_path}"
  namespace           = "AWS/Route53"
  metric_name         = "HealthCheckStatus"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.period
  statistic           = "Minimum"
  threshold           = var.threshold
  unit                = "None"
  dimensions = {
    HealthCheckId = aws_route53_health_check.this.id
  }
  alarm_description         = var.alarm_description == null ? "${var.domain_name}/${var.resource_path} is down" : var.alarm_description
  alarm_actions             = [aws_sns_topic.this.arn]
  ok_actions                = [aws_sns_topic.this.arn]
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  depends_on = [
    aws_route53_health_check.this
  ]

  tags = var.tags
}

resource "aws_sns_topic" "this" {
  name              = var.alarm_prefix
  kms_master_key_id = var.kms_id
  tags              = var.tags
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.alarm_endpoint_protocol
  endpoint  = var.alarm_endpoint
}

// Refer : https://github.com/dasmeta/terraform-aws-modules/blob/v2.6.2/modules/route53-alerts-notify/variables.tf
