module "cwe" {
  source      = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe?ref=v1.0.0"
  name        = "CloudtrailLoggingStopped"
  description = "Detects when a CloudTrail Trail has logging turned off."

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
