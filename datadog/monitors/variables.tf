variable "name" {
  type        = string
  description = "Name of the entity monitored within the SUI Network. This name is used to uniquely identify the monitor's target within Datadog."
}

variable "environment" {
  type        = string
  description = "Deployment environment of the SUI Network being monitored. Common values include 'mainnet', 'testnet', or custom environment names. Default is set to 'testnet'."
  default     = "testnet"
}

variable "service" {
  type        = string
  description = "Type of service within the SUI Network that is being monitored. For instance, 'validator' represents a node that participates in consensus. Default is set to 'validator'."
  default     = "validator"
}

variable "chain_id" {
  type        = string
  description = "Unique identifier for the blockchain within the SUI Network. This ID is used to distinguish between different chains or networks. Default is set to a specific chain identifier."
  default     = "4c78adac"
}

variable "evaluation_delay" {
  description = "The delay, in seconds, before evaluating the metric to account for data ingestion latency. Helps ensure data completeness for accurate monitoring."
  default     = 300
}

variable "notify_no_data" {
  description = "Enables alerts for 'no data' events, indicating possible issues with data reporting or collection from the Sui validator."
  default     = true
}

variable "no_data_timeframe" {
  description = "Duration, in minutes, to wait before alerting on a 'no data' condition, signaling potential interruptions in data flow or metric collection."
  default     = 15
}

variable "notification_preset_name" {
  description = "Configures the detail level in monitor notifications. Options: 'show_all', 'hide_query', 'hide_handles', 'hide_all'. Tailors notifications to include essential information."
  default     = "hide_handles"
}

variable "renotify_interval" {
  description = "Interval, in minutes, between re-notifications for unresolved issues, ensuring timely follow-ups on critical Sui validator performance metrics."
  default     = 15
}

variable "renotify_occurrences" {
  description = "Specifies the maximum number of re-notification messages for unresolved alerts, controlling alert frequency on ongoing issues."
  default     = 2
}

variable "renotify_statuses" {
  type        = list(string)
  description = "Defines the alert statuses (e.g., 'alert', 'warn', 'no data') that trigger re-notifications, allowing for targeted follow-ups on specific conditions."
  default     = ["alert", "warn", "no data"]

  validation {
    condition = alltrue([
                  for status in var.renotify_statuses : 
                  contains(["alert", "warn", "no data"], status)
                ])
    error_message = "Each status in 'renotify_statuses' must be one of the following values: 'alert', 'warn', 'no data'."
  }
}

variable "notification_targets" {
  type        = map(list(string))
  default     = {}
  description = "A map specifying notification targets for different alert thresholds. It allows defining custom notification channels for 'critical' and 'warning' alerts, ensuring appropriate alert routing. Each channel should be specified with a unique identifier, prefixed with '@'. Format: {'critical': ['@channel1', '@user'], 'warning': ['@channel2']}."

  validation {
    condition = can(var.notification_targets) && alltrue([
                  can(tomap(var.notification_targets)),
                  alltrue([
                    for key, value in var.notification_targets : 
                    contains(["critical", "warning"], key) && 
                    can(toset(value)) && 
                    alltrue([
                      for target in value : regex("^@[0-9a-zA-Z-_]+$", target)
                    ])
                  ])
                ])
    error_message = "The 'notification_targets' map must include only 'critical' and 'warning' keys with lists of notification channel identifiers, each starting with '@'. Ensure the map is not empty and all identifiers are correctly formatted."
  }
}

variable "tags" {
  type        = list(string)
  description = "A list of tags to be associated with the Datadog monitors. Tags are key-value pairs that help in categorizing and filtering monitors across different environments, teams, or service types, enhancing manageability and visibility."
  default     = []
}

variable "high_consensus_latency_enabled" {
  description = "Enables monitoring for high consensus latency on the Sui validator, a critical metric for assessing network participation efficiency."
  type        = string
  default     = "true"
}

variable "high_consensus_latency_message" {
  description = "Customizable notification message for the High Consensus Latency monitor, allowing for tailored alerts specific to Sui validator operations."
  type        = string
  default     = ""
}

variable "high_consensus_latency_escalation_message" {
  description = "A message to include with a re-notification for the High Consensus Latency monitor escalation."
  type        = string
  default     = ""
}

variable "high_consensus_latency_aggregator" {
  type        = string
  description = "Aggregation method for evaluating consensus latency over the specified timeframe, crucial for identifying performance trends. Valid options are 'min', 'max', 'avg'."
  default     = "avg"

  validation {
    condition     = contains(["min", "max", "avg"], var.high_consensus_latency_aggregator)
    error_message = "The 'high_consensus_latency_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "high_consensus_latency_timeframe" {
  type        = string
  description = "Time window for assessing High Consensus Latency, setting the scope for performance evaluation of the Sui validator. Valid options are 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.high_consensus_latency_timeframe)
    error_message = "The 'high_consensus_latency_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "high_consensus_latency_threshold_critical" {
  default     = 10
  description = "Critical alert threshold for consensus latency (in seconds), beyond which the validator's performance is considered severely impacted."
}

variable "high_consensus_latency_threshold_warning" {
  default     = 8
  description = "Warning threshold for consensus latency (in seconds), indicating the onset of performance degradation that may impact validator efficiency."
}

variable "high_owned_objects_certificates_execution_latency_enabled" {
  description = "Activates monitoring for high execution latency of owned objects' certificates, crucial for ensuring timely transaction processing."
  type        = string
  default     = "true"
}

variable "high_owned_objects_certificates_execution_latency_message" {
  description = "Custom message for alerts on high execution latency of owned objects' certificates, enabling specific guidance for troubleshooting."
  type        = string
  default     = ""
}

variable "high_owned_objects_certificates_execution_latency_escalation_message" {
  description = "A custom message to include with a re-notification for the High Owned Objects Certificates Execution Latency monitor escalation."
  type        = string
  default     = ""
}

variable "high_owned_objects_certificates_execution_latency_aggregator" {
  description = "Determines how execution latency data is aggregated (e.g., 'avg'), essential for accurate performance assessment over time."
  type        = string
  default     = "avg"

  validation {
    condition     = contains(["min", "max", "avg"], var.high_owned_objects_certificates_execution_latency_aggregator)
    error_message = "The 'high_owned_objects_certificates_execution_latency_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "high_owned_objects_certificates_execution_latency_timeframe" {
  description = "Defines the observation period for execution latency monitoring, vital for identifying and addressing performance issues promptly."
  type        = string
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.high_owned_objects_certificates_execution_latency_timeframe)
    error_message = "The 'high_owned_objects_certificates_execution_latency_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "high_owned_objects_certificates_execution_latency_threshold_critical" {
  default     = 3000
  description = "Critical latency threshold in milliseconds for owned objects' certificates execution, highlighting severe performance issues."
}

variable "high_owned_objects_certificates_execution_latency_threshold_warning" {
  default     = 2000
  description = "Warning threshold in milliseconds for execution latency, indicating potential concerns that could escalate if unaddressed."
}

variable "high_shared_objects_certificates_execution_latency_enabled" {
  description = "Enables alerts for high latency in executing shared objects' certificates, key for maintaining overall network responsiveness."
  type        = string
  default     = "true"
}

variable "high_shared_objects_certificates_execution_latency_message" {
  description = "Alert message customization for high execution latency of shared objects' certificates, facilitating targeted response actions."
  type        = string
  default     = ""
}

variable "high_shared_objects_certificates_execution_latency_escalation_message" {
  description = "A custom message to include with a re-notification for the High Shared Objects Certificates Execution Latency monitor escalation."
  type        = string
  default     = ""
}

variable "high_shared_objects_certificates_execution_latency_aggregator" {
  description = "Aggregation strategy (e.g., 'avg') for latency metrics, crucial for a balanced view of network performance across time intervals."
  type        = string
  default     = "avg"

  validation {
    condition     = contains(["min", "max", "avg"], var.high_shared_objects_certificates_execution_latency_aggregator)
    error_message = "The 'high_shared_objects_certificates_execution_latency_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "high_shared_objects_certificates_execution_latency_timeframe" {
  description = "Specifies the monitoring window for evaluating execution latency, essential for timely detection of performance degradation."
  type        = string
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.high_shared_objects_certificates_execution_latency_timeframe)
    error_message = "The 'high_shared_objects_certificates_execution_latency_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "high_shared_objects_certificates_execution_latency_threshold_critical" {
  default     = 5
  description = "Sets the critical alert threshold in seconds for shared objects' certificates execution latency, marking unacceptable performance levels."
}

variable "high_shared_objects_certificates_execution_latency_threshold_warning" {
  default     = 4
  description = "Warning level for execution latency in seconds, serving as an early indicator of potential slowdowns in transaction processing."
}

variable "low_certificate_creation_rate_enabled" {
  description = "Turns on monitoring for low certificate creation rates, indicative of underperformance in transaction validation or network participation."
  type        = string
  default     = "true"
}

variable "low_certificate_creation_rate_message" {
  description = "Allows for a custom alert message when the certificate creation rate falls below expected levels, aiding in prompt issue identification."
  type        = string
  default     = ""
}

variable "low_certificate_creation_rate_escalation_message" {
  description = "A custom message to include with a re-notification for the Low Certificate Creation Rate monitor escalation."
  type        = string
  default     = ""
}

variable "low_certificate_creation_rate_aggregator" {
  description = "Aggregator function (e.g., 'avg') for calculating the certificate creation rate, important for accurate monitoring of validator activity."
  type        = string
  default     = "avg"

  validation {
    condition     = contains(["min", "max", "avg"], var.low_certificate_creation_rate_aggregator)
    error_message = "The 'low_certificate_creation_rate_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "low_certificate_creation_rate_timeframe" {
  description = "Observation period for certificate creation rate, critical for assessing the validator's contribution to the network's security and efficiency."
  type        = string
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.low_certificate_creation_rate_timeframe)
    error_message = "The 'low_certificate_creation_rate_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "low_certificate_creation_rate_threshold_critical" {
  default     = 0.5
  description = "Critical threshold for certificate creation rate, in certificates per second, below which the validator's activity is considered alarmingly low."
}

variable "low_certificate_creation_rate_threshold_warning" {
  default     = 1
  description = "Warning threshold for certificate creation rate, indicating early signs of reduced validator engagement or network issues."
}

variable "low_checkpoints_execution_rate_enabled" {
  description = "Enables the monitor for tracking low checkpoints execution rate, crucial for identifying delays or inefficiencies in processing checkpoints."
  type        = string
  default     = "true"
}

variable "low_checkpoints_execution_rate_message" {
  description = "Customizable alert message for low checkpoints execution rate, allowing for specific instructions or insights to be communicated during alerts."
  type        = string
  default     = ""
}

variable "low_checkpoints_execution_rate_escalation_message" {
  description = "A custom message to include with a re-notification for the Low Checkpoints Execution Rate monitor escalation."
  type        = string
  default     = ""
}

variable "low_checkpoints_execution_rate_aggregator" {
  description = "Determines the aggregation method (e.g., 'max') for calculating the checkpoints execution rate, vital for assessing overall performance trends."
  type        = string
  default     = "max"

  validation {
    condition     = contains(["min", "max", "avg"], var.low_checkpoints_execution_rate_aggregator)
    error_message = "The 'low_checkpoints_execution_rate_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "low_checkpoints_execution_rate_timeframe" {
  description = "Defines the evaluation period for the low checkpoints execution rate monitor, setting the context for performance analysis."
  type        = string
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.low_checkpoints_execution_rate_timeframe)
    error_message = "The 'low_checkpoints_execution_rate_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "low_checkpoints_execution_rate_shift_timeframe" {
  description = "Specifies the comparison timeframe for assessing changes in the checkpoints execution rate, aiding in trend analysis and anomaly detection."
  type        = string
  default     = "last_5m"
}

variable "low_checkpoints_execution_rate_threshold_critical" {
  description = "Sets the critical alert threshold for checkpoints execution rate, below which the performance is considered significantly impaired."
  default     = 0.5
}

variable "low_checkpoints_execution_rate_threshold_warning" {
  description = "Establishes the warning threshold for checkpoints execution rate, indicating the onset of potential performance issues."
  default     = 1
}

variable "low_consensus_proposal_rate_enabled" {
  description = "Activates the monitor for observing low consensus proposal rates, essential for maintaining the validator's active participation in consensus."
  type        = string
  default     = "true"
}

variable "low_consensus_proposal_rate_message" {
  description = "Allows for a tailored alert message regarding low consensus proposal rates, facilitating targeted actions for maintaining network integrity."
  type        = string
  default     = ""
}

variable "low_consensus_proposal_rate_escalation_message" {
  description = "A custom message to include with a re-notification for the Low Consensus Proposal Rate monitor escalation."
  type        = string
  default     = ""
}

variable "low_consensus_proposal_rate_aggregator" {
  description = "Specifies the aggregation method (e.g., 'avg') for evaluating consensus proposal rates, critical for understanding participation effectiveness."
  type        = string
  default     = "avg"

  validation {
    condition     = contains(["min", "max", "avg"], var.low_consensus_proposal_rate_aggregator)
    error_message = "The 'low_consensus_proposal_rate_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "low_consensus_proposal_rate_timeframe" {
  description = "Sets the timeframe for monitoring low consensus proposal rates, crucial for timely detection of decreased network engagement."
  type        = string
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.low_consensus_proposal_rate_timeframe)
    error_message = "The 'low_consensus_proposal_rate_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "low_consensus_proposal_rate_threshold_critical" {
  description = "Critical alert threshold for consensus proposal rates, below which indicates significant issues with validator's engagement in consensus."
  default     = 1
}

variable "low_consensus_proposal_rate_threshold_warning" {
  description = "Warning threshold for consensus proposal rates, signaling early warnings of reduced engagement in the consensus process."
  default     = 0.8
}

variable "low_rounds_progression_enabled" {
  description = "Enables monitoring for low rounds progression, vital for identifying blocks or consensus stages that are not advancing as expected."
  type        = string
  default     = "true"
}

variable "low_rounds_progression_message" {
  description = "Custom message for alerts on low rounds progression, providing context or remediation steps for addressing the detected issues."
  type        = string
  default     = ""
}

variable "low_rounds_progression_escalation_message" {
  description = "A custom message to include with a re-notification for the Low Rounds Progression monitor escalation."
  type        = string
  default     = ""
}

variable "low_rounds_progression_aggregator" {
  description = "Aggregation method (e.g., 'max') for the low rounds progression monitor, important for evaluating the progression efficiency of rounds."
  type        = string
  default     = "max"

  validation {
    condition     = contains(["min", "max", "avg"], var.low_rounds_progression_aggregator)
    error_message = "The 'low_rounds_progression_aggregator' must be one of the following values: 'min', 'max', 'avg'."
  }
}

variable "low_rounds_progression_timeframe" {
  description = "Timeframe for assessing low rounds progression, essential for ensuring timely and effective participation in the consensus mechanism."
  type        = string
  default     = "last_5m"

  validation {
    condition     = contains(["last_1m", "last_5m", "last_10m", "last_15m", "last_30m", "last_1h", "last_2h", "last_4h", "last_1d"], var.low_rounds_progression_timeframe)
    error_message = "The 'low_rounds_progression_timeframe' must be one of the following values: 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'."
  }
}

variable "low_rounds_progression_shift_timeframe" {
  description = "Specifies the comparison timeframe for assessing changes in the rounds progression, aiding in trend analysis and anomaly detection."
  type        = string
  default     = "last_5m"
}

variable "low_rounds_progression_threshold_critical" {
  description = "Defines the critical threshold for rounds progression alerts, indicating no advancement in consensus rounds within the specified timeframe."
  default     = 0
}

variable "low_rounds_progression_threshold_warning" {
  description = "Warning level for rounds progression, designed to alert on early signs of slowing or stalling in consensus round advancement."
  default     = 0.5
}