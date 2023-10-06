module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

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
  search_string     = "Health" // Note:- string with space(eg. "Health API") is not working , it always goes to in-alarm state
  alarm_endpoint    = "https://api.opsgenie.com/v1/json/cloudwatch?apiKey=xxxxx-xx-4xxc9c-xx-xxxx"

  tags = module.tags.tags

}
