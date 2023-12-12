#!/usr/bin/env bash

BUCKET="$1";
LAMBDA_ARN="$2";
EVENTS="$3";
PREFIX="$4";
SUFFIX="$5";
NOTIFICATION_ID="$6";

APPEND_DATA=".LambdaFunctionConfigurations += [{
    \"Id\": \"$NOTIFICATION_ID\",
    \"LambdaFunctionArn\": \"$LAMBDA_ARN\",
    \"Events\": [
        $EVENTS
    ],
    \"Filter\": {
        \"Key\": {
            \"FilterRules\": [
                {
                    \"Name\": \"Prefix\",
                    \"Value\": \"$PREFIX\"
                },
                {
                    \"Name\": \"Suffix\",
                    \"Value\": \"$SUFFIX\"
                }
            ]
        }
    }
}]";
CONFIG=$(aws s3api get-bucket-notification-configuration --bucket "$BUCKET")
CONFIG="${CONFIG:-"{}"}"
echo "$CONFIG" | jq "$APPEND_DATA" > append.json;
aws s3api put-bucket-notification-configuration --bucket "$BUCKET" --notification-configuration file://append.json;
