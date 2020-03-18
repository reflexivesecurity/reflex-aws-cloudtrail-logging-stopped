""" Module for CloudtrailLoggingStopped """

import json
import os

import boto3
from reflex_core import AWSRule


class CloudTrailLoggingStopped(AWSRule):
    """ Rule to detect CloudTrail logging being stopped.  """

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

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return f"The trail {self.trail_name} has had logging stopped."


def lambda_handler(event, _):
    """ Handles the incoming event """
    rule = CloudTrailLoggingStopped(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
