module "cwe" {
  source      = "git::https://github.com/reflexivesecurity/reflex-engine.git//modules/cwe?ref=v2.1.1"
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
