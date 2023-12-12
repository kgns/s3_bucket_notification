#!/usr/bin/env bash

BUCKET="$1";
NOTIFICATION_ID="$2";

CONFIG=$(aws s3api get-bucket-notification-configuration --bucket "$BUCKET")
CONFIG="${CONFIG:-"{}"}"
echo "$CONFIG" | jq "( .LambdaFunctionConfigurations | arrays ) |= map(select(.Id != \"$NOTIFICATION_ID\"))" > remove.json;
aws s3api put-bucket-notification-configuration --bucket "$BUCKET" --notification-configuration file://remove.json;
