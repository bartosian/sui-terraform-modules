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
    critical = var.high_consensus_latency_aggregator_threshold_critical
    warning  = var.high_consensus_latency_aggregator_threshold_warning
  }

  renotify_interval        = var.renotify_interval
  renotify_occurrences     = var.renotify_occurrences
  renotify_statuses        = var.renotify_statuses
  include_tags             = true
  notify_no_data           = var.notify_no_data
  no_data_timeframe        = var.no_data_timeframe
  notification_preset_name = var.notification_preset_name

  evaluation_delay     = var.evaluation_delay
  new_group_delay      = var.new_group_delay

  tags = concat(local.common_tags, var.tags)
}

# Resource    : Datadog Monitor JSON
# Description : Terraform resource to create and manage Datadog monitor for SUI Validator Owned Objects Certificates Execution Latency.
resource "datadog_monitor" "validator_high_owned_objects_certificates_execution_latency_monitor" {
  name               = "High Owned Objects Certificates Execution Latency"
  type               = "query alert"
  priority           = 1
  message            = "{{!-- Warning Section --}}\n{{#is_warning}}\n{{override_priority 'P2'}}\n🔔\n{{/is_warning}}\n\n{{!-- Warning Recovery Section --}}\n{{#is_warning_recovery}}\n✅\n{{/is_warning_recovery}}\n\n{{!-- Alert Section --}}\n{{#is_alert}}\n{{override_priority 'P1'}}\n🚨\n{{/is_alert}}\n\n{{!-- Alert Recovery Section --}}\n{{#is_alert_recovery}}\n✅\n{{/is_alert_recovery}}\n\n-------------------------------------------------\n🕒 *Triggered at (UTC):* {{last_triggered_at}}",

  query = "avg(last_15m):avg:sui.validator.validator_service_handle_certificate_non_consensus_latency{env:testnet, service:validator, pct:95} > 3000"

  monitor_thresholds {
    warning  = 2000
    critical = 3000
  }

  include_tags = true
  tags = ["foo:bar", "team:fooBar"]

  renotify_interval = 30
  renotify_occurrences = 3
  renotify_statuses = [ "alert", "no data"]

  no_data_timeframe        = 30
  evaluation_delay         = 60
  new_group_delay          = 300
  notification_preset_name = "hide_handles"
}

