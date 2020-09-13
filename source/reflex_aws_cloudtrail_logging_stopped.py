""" Module for CloudtrailLoggingStopped """

import json
import os

import boto3
from reflex_core import AWSRule, subscription_confirmation


class CloudTrailLoggingStopped(AWSRule):
    """ Rule to detect CloudTrail logging being stopped.  """

    client = boto3.client("cloudtrail")

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required event data """
        self.trail_name = event["detail"]["requestParameters"]["name"]

    def resource_compliant(self):
        """
        Determine if the resource is compliant with your rule.

        Return True if it is compliant, and False if it is not.
        """
        return False

    def remediate(self):
        """ Fix the non-compliant resource so it conforms to the rule """
        self.client.start_logging(Name=self.trail_name)

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        message = f"The trail {self.trail_name} has had logging stopped."
        if self.should_remediate():
            message += "Logging has been restarted."

        return message


def lambda_handler(event, _):
    """ Handles the incoming event """
    print(event)
    if subscription_confirmation.is_subscription_confirmation(event):
        subscription_confirmation.confirm_subscription(event)
        return
    rule = CloudTrailLoggingStopped(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
