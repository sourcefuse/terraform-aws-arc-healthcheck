variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags object."
}

variable "name" {
  type        = string
  description = "Health check name"
}

variable "domain_name" {
  type        = string
  description = "Domain name or ip address of checking service."
}

variable "resource_path" {
  type        = string
  default     = ""
  description = "Resource path eg. /health"
}

variable "port" {
  type        = number
  default     = 443
  description = "Port number of checking service."
}

variable "type" {
  type        = string
  default     = "HTTPS"
  description = "Type of health check. eg. HTTPS_STR_MATCH, HTTPS, HTTP"
}

variable "measure_latency" {
  type        = string
  default     = false
  description = "Indicates whether you want Route 53 to measure the latency between health checkers in multiple AWS regions and your endpoint and to display CloudWatch latency graphs in the Route 53 console."
}


variable "alarm_prefix" {
  type        = string
  description = "Prefix for Alarm"
}

variable "failure_threshold" {
  type        = number
  description = "The number of consecutive health checks that an endpoint must pass or fail."
}

variable "request_interval" {
  type        = number
  description = "The number of seconds between the time that Amazon Route 53 gets a response from your endpoint and the time that it sends the next health-check request."
}

variable "search_string" {
  type        = string
  description = "String searched in the first 5120 bytes of the response body for check to be considered healthy. Only valid with HTTP_STR_MATCH and HTTPS_STR_MATCH"
  default     = null
}

variable "evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "period" {
  type        = number
  default     = 10
  description = "The period in seconds over which the specified statistic is applied. Valid values are 10, 30, or any multiple of 60"
}

variable "threshold" {
  type        = number
  default     = 1
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models."
}

variable "alarm_description" {
  type        = string
  default     = null
  description = "Alarm description"
}

variable "alarm_endpoint" {
  type        = string
  default     = ""
  description = "Alarm endpoint, this get added as a subcription to SNS"
}

variable "alarm_endpoint_protocol" {
  type        = string
  default     = "https"
  description = "Protocol to use. Valid values are: sqs, sms, lambda, firehose, and application. Protocols email, email-json, http and https are also valid but partially supported. See details below."
}
