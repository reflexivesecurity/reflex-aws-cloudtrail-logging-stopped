module "reflex_aws_cloudtrail_logging_stopped" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.4"
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

  function_name   = "CloudTrailLoggingStopped"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_cloudtrail_logging_stopped.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    
  }



  queue_name    = "CloudtrailLoggingStopped"
  delay_seconds = 0

  target_id = "CloudtrailLoggingStopped"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
