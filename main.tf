resource "null_resource" "s3_bucket_notification" {
  triggers = {
    prefix          = var.prefix
    suffix          = var.suffix
    events          = "\"${join("\",\"", var.events)}\""
    lambda_arn      = var.lambda_arn
    notification_id = var.notification_id
    bucket          = var.s3_bucket_name
  }

  provisioner "local-exec" {
    command     = "/bin/bash append.sh '${self.triggers.bucket}' '${self.triggers.lambda_arn}' '${self.triggers.events}' '${self.triggers.prefix}' '${self.triggers.suffix}' '${self.triggers.notification_id}'"
    working_dir = path.module
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "/bin/bash remove.sh '${self.triggers.bucket}' '${self.triggers.lambda_arn}' '${self.triggers.events}' '${self.triggers.prefix}' '${self.triggers.suffix}' '${self.triggers.notification_id}'"
    working_dir = path.module
  }
}
