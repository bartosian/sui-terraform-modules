locals {
  monitors = {
    "validator_high_consensus_latency" = {
      enabled    = var.high_consensus_latency_enabled
      name       = "High Consensus Latency"
      type       = "metric alert"
      priority   = var.high_consensus_latency_priority
      query      = "${var.high_consensus_latency_aggregator}(${var.high_consensus_latency_timeframe}):avg:sui.validator.sequencing_certificate_latency.sum${local.filter_tags}.as_rate() / avg:sui.validator.sequencing_certificate_latency.count${local.filter_tags}.as_rate() > ${var.high_consensus_latency_threshold_critical}"
      thresholds = {
        critical = var.high_consensus_latency_threshold_critical
        warning  = var.high_consensus_latency_threshold_warning
      }
    },
    "validator_high_owned_objects_certificates_execution_latency" = {
      enabled    = var.high_owned_objects_certificates_execution_latency_enabled
      name       = "High Owned Objects Certificates Execution Latency"
      type       = "query alert"
      priority   = var.high_owned_objects_certificates_execution_latency_priority
      query      = "${var.high_owned_objects_certificates_execution_latency_aggregator}(${var.high_owned_objects_certificates_execution_latency_timeframe}):avg:sui.validator.validator_service_handle_certificate_non_consensus_latency${local.filter_tags} > ${var.high_owned_objects_certificates_execution_latency_threshold_critical}"
      thresholds = {
        critical = var.high_owned_objects_certificates_execution_latency_threshold_critical
        warning  = var.high_owned_objects_certificates_execution_latency_threshold_warning
      }
    },
    "validator_high_shared_objects_certificates_execution_latency_monitor" = {
      enabled    = var.high_shared_objects_certificates_execution_latency_enabled
      name       = "High Shared Objects Certificates Execution Latency"
      type       = "query alert"
      priority   = var.high_shared_objects_certificates_execution_latency_priority
      query      = "${var.high_shared_objects_certificates_execution_latency_aggregator}(${var.high_shared_objects_certificates_execution_latency_timeframe}):avg:sui.validator.validator_service_handle_certificate_consensus_latency${local.filter_tags} / 1000 > ${var.high_shared_objects_certificates_execution_latency_threshold_critical}"
      thresholds = {
        critical = var.high_shared_objects_certificates_execution_latency_threshold_critical
        warning  = var.high_shared_objects_certificates_execution_latency_threshold_warning
      }
    },
    "validator_low_certificate_creation_rate_monitor" = {
      enabled    = var.low_certificate_creation_rate_enabled
      name       = "Low Certificate Creation Rate"
      type       = "query alert"
      priority   = var.low_certificate_creation_rate_priority
      query      = "${var.low_certificate_creation_rate_aggregator}(${var.low_certificate_creation_rate_timeframe}):sum:sui.validator.certificates_created.count${local.filter_tags}.as_rate() < ${var.low_certificate_creation_rate_threshold_critical}"
      thresholds = {
        critical = var.low_certificate_creation_rate_threshold_critical
        warning  = var.low_certificate_creation_rate_threshold_warning
      }
    }
  }
}

# Resource: Datadog Monitor for SUI Validator Metrics
# Description: This Terraform resource dynamically creates and manages Datadog monitors tailored for monitoring 
# various metrics associated with SUI Validators. It leverages a dynamic approach using the `for_each` construct 
# to iterate over a predefined set of monitor configurations. Each monitor configuration is conditionally applied 
# based on its enabled status, allowing for flexible and scalable monitoring solutions.
resource "datadog_monitor" "sui_validator_monitor" {
  for_each = {for key, monitor in local.monitors: key => monitor if monitor.enabled == "true"}

  name               = "[${var.environment}] [${var.name}] [${var.validator}] ${each.value.name} {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  type               = each.value.type
  priority           = each.value.priority
  message            = templatefile("${path.module}/templates/messages/validator_monitor_message.tftpl", local.message_template_variables)
  query              = each.value.query

  monitor_thresholds = {
    critical = each.value.thresholds.critical
    warning  = each.value.thresholds.warning
  }

  renotify_interval        = var.renotify_interval
  renotify_occurrences     = var.renotify_occurrences
  renotify_statuses        = var.renotify_statuses
  notify_no_data           = var.notify_no_data
  no_data_timeframe        = var.no_data_timeframe
  notification_preset_name = var.notification_preset_name
  include_tags             = true
  evaluation_delay         = var.evaluation_delay
  new_group_delay          = var.new_group_delay
  tags                     = concat(local.common_tags, var.tags)
}
