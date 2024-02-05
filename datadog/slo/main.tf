locals {
  monitors = {
    "validator_consensus_latency" = {
      enabled     = var.consensus_latency_enabled
      name        = "Consensus Latency SLO"
      type        = "monitor"
      description = "The Consensus Latency SLO is delineated by the **validator_service_handle_certificate_non_consensus_latency** histogram, which captures the latency encountered in sequencing transactions that are submitted to the consensus mechanism by a designated validator. In typical operational scenarios, the expected average latency hovers below 3 seconds. In alignment with this benchmark, the defined Service Level Objective (SLO) is to uphold latency below 10 seconds. This threshold is critical for ensuring the efficacy of transaction processing and upholding superior standards of network performance."
      monitor_ids = var.consensus_latency_monitor_ids
      thresholds = {
        timeframe = var.consensus_latency_timeframe
        target    = var.consensus_latency_target
        warning   = var.consensus_latency_warning
      }
    },
    "validator_owned_objects_certificates_execution_latency" = {
      enabled     = var.owned_objects_certificates_execution_latency_enabled
      name        = "Owned Objects Certificates Execution Latency SLO"
      type        = "monitor"
      description = "The Owned Objects Certificates Execution Latency SLO is defined by the **validator_service_handle_certificate_non_consensus_latency** histogram, which quantifies the execution latency for owned object certificates that operate independently of consensus mechanisms on the critical path. Under normal operating conditions, the average latency is observed to be around 500 milliseconds. The established Service Level Objective (SLO) for this metric is to maintain execution latency below 3 seconds, ensuring efficient processing and timely execution of owned object certificates within the network infrastructure."
      monitor_ids = var.owned_objects_certificates_execution_latency_monitor_ids
      thresholds = {
        timeframe = var.owned_objects_certificates_execution_latency_timeframe
        target    = var.owned_objects_certificates_execution_latency_target
        warning   = var.owned_objects_certificates_execution_latency_warning
      }
    },
    "validator_shared_objects_certificates_execution_latency" = {
      enabled     = var.shared_objects_certificates_execution_latency_enabled
      name        = "Shared Objects Certificates Execution Latency SLO"
      type        = "monitor"
      description = "The Shared Objects Certificates Execution Latency SLO is represented by the **validator_service_handle_certificate_consensus_latency** histogram, which tracks the execution latency (measured in milliseconds) of shared object certificates. It is pivotal for the 95th percentile (p95) latency to remain under 5 seconds. This SLO is crucial for ensuring that shared object certificate processing is both swift and efficient, contributing to the overall reliability and performance of the network infrastructure by minimizing delays in consensus-related operations."
      monitor_ids = var.shared_objects_certificates_execution_latency_monitor_ids
      thresholds = {
        timeframe = var.shared_objects_certificates_execution_latency_timeframe
        target    = var.shared_objects_certificates_execution_latency_target
        warning   = var.shared_objects_certificates_execution_latency_warning
      }
    },
    "validator_certificate_creation_rate_monitor" = {
      enabled    = var.certificate_creation_rate_enabled
      name       = "Certificate Creation Rate SLO"
      type        = "monitor"
      description = "The Certificate Creation Rate SLO is defined by the **certificates_created** counter, which increments each time a validator certifies a Narwhal proposal. The consistent rate of certified Narwhal proposals is vital to ensure the dependable operation of the system. In a robust and healthy system, validators should generate a minimum of one certified Narwhal proposal per second, guaranteeing the smooth and reliable functioning of the system's consensus mechanism. This SLO serves as a critical performance metric to maintain the system's stability and efficiency."
      monitor_ids = var.certificate_creation_rate_monitor_ids
      thresholds = {
        timeframe = var.certificate_creation_rate_timeframe
        target    = var.certificate_creation_rate_target
        warning   = var.certificate_creation_rate_warning
      }
    },
    "validator_consensus_reliability" = {
      enabled     = var.consensus_reliability_enabled
      name        = "Consensus Reliability SLO"
      type        = "monitor"
      description = "The Consensus Reliability SLO is defined by the **certificates_created** counter, which increments each time a validator certifies a Narwhal proposal. The consistent rate of certified Narwhal proposals is vital to ensure the dependable operation of the system. In a robust and healthy system, validators should generate a minimum of one certified Narwhal proposal per second, guaranteeing the smooth and reliable functioning of the system's consensus mechanism. This SLO serves as a critical performance metric to maintain the system's stability and efficiency."
      monitor_ids = var.consensus_reliability_monitor_ids
      thresholds = {
        timeframe = var.consensus_reliability_timeframe
        target    = var.consensus_reliability_target
        warning   = var.consensus_reliability_warning
      }
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

  name    = "[${var.environment}] [${var.name}] [${var.service}] ${each.value.name} {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  type    = each.value.type
  priority = each.value.priority
  message = each.value.message != "" ? each.value.message : templatefile("${path.module}/templates/messages/validator_monitor_message.tftpl", {
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

  query = each.value.query

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
  tags                     = concat(local.shared_tags, var.tags)
}