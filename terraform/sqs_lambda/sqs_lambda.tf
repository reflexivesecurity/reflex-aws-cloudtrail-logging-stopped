module "sqs_lambda" {
  source                    = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/sqs_lambda?ref=v2.1.0"
  cloudwatch_event_rule_id  = var.cloudwatch_event_rule_id
  cloudwatch_event_rule_arn = var.cloudwatch_event_rule_arn
  function_name             = "CloudtrailLoggingStopped"
  package_location          = var.package_location
  handler                   = "reflex_aws_cloudtrail_logging_stopped.lambda_handler"
  lambda_runtime            = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    MODE      = var.mode
  }
  custom_lambda_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudtrail:StartLogging"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF


  queue_name    = "CloudtrailLoggingStopped"
  delay_seconds = 0

  target_id = "CloudtrailLoggingStopped"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
