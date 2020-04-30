module "reflex_aws_cloudtrail_logging_stopped_cwe" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_?ref=region-refactor"
  rule_name        = "CloudtrailLoggingStopped"
  rule_description = "Detects when a CloudTrail Trail has logging turned off."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.cloudtrail"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "cloudtrail.amazonaws.com"
    ],
    "eventName": [
      "StopLogging"
    ]
  }
}
PATTERN
}
