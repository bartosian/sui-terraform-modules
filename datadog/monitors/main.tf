locals {
  message_template_variables = {
    env         = upper(terraform.workspace == "prod" ? terraform.workspace : "sandbox")
    lambda_name = var.lambda_name
    notification_targets = {
      critical : join(" ", distinct(lookup(var.notification_targets, "critical", [""])))
      warning : join(" ", distinct(lookup(var.notification_targets, "warning", [""])))
    }
  }
}

# Resource    : Datadog Monitor JSON
# Description : Terraform resource to create and manage Datadog monitor for SUI Validator Consensus Latency.
resource "datadog_monitor" "validator_high_consensus_latency_monitor" {
  count              = var.high_consensus_latency_enabled == "true" ? 1 : 0
  name               = "[${var.environment}] [${var.name}] [${var.validator}] High Consensus Latency {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  type               = "metric alert"
  priority           = var.high_consensus_latency_priority
  message            = templatefile("${path.module}/templates/messages/validator_monitor_message.tftpl", local.message_template_variables)


  query = <<EOQ
    ${var.high_consensus_latency_aggregator}(${var.high_consensus_latency_timeframe}):
      avg:sui.validator.sequencing_certificate_latency.sum${locals.filter-tags}.as_rate()
      /
      avg:sui.validator.sequencing_certificate_latency.count${locals.filter-tags}.as_rate()
      > ${var.high_consensus_latency_threshold_critical}
  EOQ

  monitor_thresholds {
    critical = var.high_consensus_latency_threshold_critical
    warning  = var.high_consensus_latency_threshold_warning
  }

  renotify_interval        = var.renotify_interval
  renotify_occurrences     = var.renotify_occurrences
  renotify_statuses        = var.renotify_statuses
  notify_no_data           = var.notify_no_data
  no_data_timeframe        = var.no_data_timeframe
  notification_preset_name = var.notification_preset_name
  include_tags             = true

  evaluation_delay     = var.evaluation_delay
  new_group_delay      = var.new_group_delay

  tags = concat(local.common_tags, var.tags)
}

# Resource    : Datadog Monitor JSON
# Description : Terraform resource to create and manage Datadog monitor for SUI Validator Owned Objects Certificates Execution Latency.
resource "datadog_monitor" "validator_high_owned_objects_certificates_execution_latency_monitor" {
  count              = var.high_owned_objects_certificates_execution_latency_enabled == "true" ? 1 : 0
  name               = "[${var.environment}] [${var.name}] [${var.validator}] High Owned Objects Certificates Execution Latency {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  type               = "query alert"
  priority           = var.high_owned_objects_certificates_execution_latency_priority
  message            = templatefile("${path.module}/templates/messages/validator_monitor_message.tftpl", local.message_template_variables)

  query = <<EOQ
    ${var.high_owned_objects_certificates_execution_latency_aggregator}(${var.high_owned_objects_certificates_execution_latency_timeframe}):
      avg:sui.validator.validator_service_handle_certificate_non_consensus_latency${locals.filter-tags}
      > ${var.high_owned_objects_certificates_execution_latency_threshold_critical}
  EOQ

  monitor_thresholds {
    critical = var.high_owned_objects_certificates_execution_latency_threshold_critical
    warning  = var.high_owned_objects_certificates_execution_latency_threshold_warning
  }

  renotify_interval        = var.renotify_interval
  renotify_occurrences     = var.renotify_occurrences
  renotify_statuses        = var.renotify_statuses
  notify_no_data           = var.notify_no_data
  no_data_timeframe        = var.no_data_timeframe
  notification_preset_name = var.notification_preset_name
  include_tags             = true

  evaluation_delay     = var.evaluation_delay
  new_group_delay      = var.new_group_delay

  tags = concat(local.common_tags, var.tags)
}

