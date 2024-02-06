locals {
  filter_tags = "{service:${var.service},env:${var.environment},chain_id:${var.chain_id},name:${var.name}}"
  monitors = {
    "validator_high_consensus_latency" = {
      enabled            = var.high_consensus_latency_enabled
      name               = "High Consensus Latency"
      type               = "metric alert"
      message            = var.high_consensus_latency_message
      escalation_message = var.high_consensus_latency_escalation_message
      priority           = 1
      query              = "${var.high_consensus_latency_aggregator}(${var.high_consensus_latency_timeframe}):avg:sui.validator.sequencing_certificate_latency.sum${local.filter_tags}.as_rate() / avg:sui.validator.sequencing_certificate_latency.count${local.filter_tags}.as_rate() > ${var.high_consensus_latency_threshold_critical}"
      thresholds         = {
        critical = var.high_consensus_latency_threshold_critical
        warning  = var.high_consensus_latency_threshold_warning
      }
      metric_unit        = "seconds"
    },
    "validator_high_owned_objects_certificates_execution_latency" = {
      enabled            = var.high_owned_objects_certificates_execution_latency_enabled
      name               = "High Owned Objects Certificates Execution Latency"
      type               = "query alert"
      message            = var.high_owned_objects_certificates_execution_latency_message
      escalation_message = var.high_owned_objects_certificates_execution_latency_escalation_message
      priority           = 1
      query              = "${var.high_owned_objects_certificates_execution_latency_aggregator}(${var.high_owned_objects_certificates_execution_latency_timeframe}):avg:sui.validator.validator_service_handle_certificate_non_consensus_latency${local.filter_tags} > ${var.high_owned_objects_certificates_execution_latency_threshold_critical}"
      thresholds         = {
        critical = var.high_owned_objects_certificates_execution_latency_threshold_critical
        warning  = var.high_owned_objects_certificates_execution_latency_threshold_warning
      }
      metric_unit        = "milliseconds"
    },
    "validator_high_shared_objects_certificates_execution_latency_monitor" = {
      enabled            = var.high_shared_objects_certificates_execution_latency_enabled
      name               = "High Shared Objects Certificates Execution Latency"
      type               = "query alert"
      message            = var.high_shared_objects_certificates_execution_latency_message
      escalation_message = var.high_shared_objects_certificates_execution_latency_escalation_message
      priority           = 1
      query              = "${var.high_shared_objects_certificates_execution_latency_aggregator}(${var.high_shared_objects_certificates_execution_latency_timeframe}):avg:sui.validator.validator_service_handle_certificate_consensus_latency${local.filter_tags} / 1000 > ${var.high_shared_objects_certificates_execution_latency_threshold_critical}"
      thresholds         = {
        critical = var.high_shared_objects_certificates_execution_latency_threshold_critical
        warning  = var.high_shared_objects_certificates_execution_latency_threshold_warning
      }
      metric_unit        = "seconds"
    },
    "validator_low_certificate_creation_rate_monitor" = {
      enabled            = var.low_certificate_creation_rate_enabled
      name               = "Low Certificate Creation Rate"
      type               = "query alert"
      message            = var.low_certificate_creation_rate_message
      escalation_message = var.low_certificate_creation_rate_escalation_message
      priority           = 1
      query              = "${var.low_certificate_creation_rate_aggregator}(${var.low_certificate_creation_rate_timeframe}):sum:sui.validator.certificates_created.count${local.filter_tags}.as_rate() < ${var.low_certificate_creation_rate_threshold_critical}"
      thresholds         = {
        critical = var.low_certificate_creation_rate_threshold_critical
        warning  = var.low_certificate_creation_rate_threshold_warning
      }
      metric_unit        = "certificates/second"
    },
    "validator_low_checkpoints_execution_rate_monitor" = {
      enabled            = var.low_checkpoints_execution_rate_enabled
      name               = "Low Checkpoints Execution Rate"
      type               = "query alert"
      message            = var.low_checkpoints_execution_rate_message
      escalation_message = var.low_checkpoints_execution_rate_escalation_message
      priority           = 1
      query              = "change(${var.low_checkpoints_execution_rate_aggregator}(${var.low_checkpoints_execution_rate_timeframe}),${var.low_checkpoints_execution_rate_shift_timeframe}):max:sui.validator.last_executed_checkpoint${local.filter_tags} <= ${var.low_checkpoints_execution_rate_threshold_critical}"
      thresholds         = {
        critical = var.low_checkpoints_execution_rate_threshold_critical
        warning  = var.low_checkpoints_execution_rate_threshold_warning
      }
      metric_unit        = "checkpoints/${var.low_checkpoints_execution_rate_timeframe}"
    },
    "validator_low_consensus_proposal_rate_monitor" = {
      enabled            = var.low_consensus_proposal_rate_enabled
      name               = "Low Consensus Proposal Rate"
      type               = "query alert"
      message            = var.low_consensus_proposal_rate_message
      escalation_message = var.low_consensus_proposal_rate_escalation_message
      priority           = 1
      query              = "${var.low_consensus_proposal_rate_aggregator}(${var.low_consensus_proposal_rate_timeframe}):avg:sui.validator.proposer_batch_latency.sum${local.filter_tags}.as_rate() / avg:sui.validator.proposer_batch_latency.count${local.filter_tags}.as_rate() > ${var.low_consensus_proposal_rate_threshold_critical}"
      thresholds         = {
        critical = var.low_consensus_proposal_rate_threshold_critical
        warning  = var.low_consensus_proposal_rate_threshold_warning
      }
      metric_unit        = "proposals/second"
    },
    "validator_low_rounds_progression_monitor" = {
      enabled            = var.low_rounds_progression_enabled
      name               = "Low Rounds Progression"
      type               = "query alert"
      message            = var.low_rounds_progression_message
      escalation_message = var.low_rounds_progression_escalation_message
      priority           = 1
      query              = "change(${var.low_rounds_progression_aggregator}(${var.low_rounds_progression_timeframe}),${var.low_rounds_progression_shift_timeframe}):max:sui.validator.current_round${local.filter_tags} <= ${var.low_rounds_progression_threshold_critical}"
      thresholds         = {
        critical = var.low_rounds_progression_threshold_critical
        warning  = var.low_rounds_progression_threshold_warning
      }
      metric_unit        = "checkpoints/${var.low_rounds_progression_timeframe}"
    }
  }
  shared_tags = ["service:${var.service}", "env:${var.environment}", "chain_id:${var.chain_id}", "name:${var.name}"]
}

# Resource: Datadog Monitor for SUI Validator Metrics
# Description: This Terraform resource dynamically creates and manages Datadog monitors tailored for monitoring 
# various metrics associated with SUI Validators. It leverages a dynamic approach using the `for_each` construct 
# to iterate over a predefined set of monitor configurations. Each monitor configuration is conditionally applied 
# based on its enabled status, allowing for flexible and scalable monitoring solutions.
resource "datadog_monitor" "sui_validator_monitor" {
  for_each = {for key, monitor in local.monitors: key => monitor if monitor.enabled == "true"}

  name    = "[${var.environment}] [${var.service}] [${var.name}] ${each.value.name} {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  type    = each.value.type
  priority = each.value.priority
  message = each.value.message != "" ? each.value.message : templatefile("${path.module}/templates/messages/validator_monitor_notification_message.tftpl", {
    critical_targets   = join(" ", distinct(lookup(var.notification_targets, "critical", [""])))
    warning_targets    = join(" ", distinct(lookup(var.notification_targets, "warning", [""])))
    environment        = var.environment
    service            = var.service
    name               = var.name
    metricType         = each.key
    metricUnit         = each.value.metric_unit
    threshold          = each.value.thresholds.critical
    warn_threshold     = each.value.thresholds.warning
  })
  escalation_message = each.value.escalation_message != "" ? each.value.escalation_message : templatefile("${path.module}/templates/messages/validator_monitor_escalation_message.tftpl", {
    critical_targets   = join(" ", distinct(lookup(var.notification_targets, "critical", [""])))
    environment        = var.environment
    service            = var.service
    name               = var.name
    metricType         = each.key
    metricUnit         = each.value.metric_unit
    threshold          = each.value.thresholds.critical
  })

  query = each.value.query

  monitor_thresholds {
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
  tags                     = concat(local.shared_tags, var.tags)
}