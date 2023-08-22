module "tags" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags?ref=1.1.0"

  environment = "dev"
  project     = "test"

  extra_tags = {
    RepoName = "terraform-aws-refarch-healthcheck"
  }
}

module "health_check" {
  source            = "../"
  name              = "test-health-check"
  domain_name       = "microservices.io"
  resource_path     = "/patterns/observability/health-check-api.html"
  type              = "HTTPS_STR_MATCH"
  measure_latency   = true
  alarm_prefix      = "test"
  failure_threshold = 2
  request_interval  = 10
  search_string     = "Pattern: Health Check API"
  alarm_endpoint    = "https://api.opsgenie.com/v1/json/cloudwatch?apiKey=75f8c6f7-5655-4a1c-b826-cef87e52e5c9"

  tags = module.tags.tags

}
