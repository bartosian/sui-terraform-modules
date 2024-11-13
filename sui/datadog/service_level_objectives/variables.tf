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

variable "tags" {
  type        = list(string)
  description = "A list of tags to be associated with the Datadog SLO. Tags are key-value pairs that help in categorizing and filtering service level objectives across different environments, teams, or service types, enhancing manageability and visibility."
  default     = []

  validation {
    condition = can(var.tags) && alltrue([
      for tag in var.tags :
      regex("^[^:]+:[^:]+( [^:]+:[^:]+)*$", tag)
    ])
    error_message = "(Optional) attribute 'tags' of 'monitor' must be of the type list with string attributes, matching the format 'key:value' (e.g., 'environment:production')."
  }
}

variable "consensus_latency_enabled" {
  description = "Enables SLO monitoring for consensus latency on the Sui validator, a critical metric for assessing network participation efficiency."
  type        = string
  default     = "true"
}

variable "consensus_latency_monitor_ids" {
  type        = list(string)  
  description = "A static set of monitor IDs to use as part of the consensus latency SLO."
  default     = []
}

variable "consensus_latency_timeframe" {
  type        = string
  description = "The time frame for the objective of the consensus latency SLO."
  default     = "7d"

  validation {
    condition     = contains(["7d", "30d", "90d", "custom"], var.consensus_latency_timeframe)
    error_message = "The 'consensus_latency_timeframe' must be one of the following values: '7d', '30d', '90d', 'custom'."
  }
}

variable "consensus_latency_target" {
  type        = number
  description = "The objective's target (0-100) for consensus latency SLO."
  default     = 99.9
}

variable "consensus_latency_warning" {
  type        = number
  description = "The warning value (0-100) for the consensus latency SLO. It must be greater than the target value."
  default     = 99.95
}

variable "owned_objects_certificates_execution_latency_enabled" {
  description = "Enables SLO monitoring for Owned Objects Certificates Execution Latency on the Sui validator, a critical metric for assessing network participation efficiency."
  type        = string
  default     = "true"
}

variable "owned_objects_certificates_execution_latency_monitor_ids" {
  type        = list(string)  
  description = "A static set of monitor IDs to use as part of the Owned Objects Certificates Execution Latency SLO."
  default     = []
}

variable "owned_objects_certificates_execution_latency_timeframe" {
  type        = string
  description = "The time frame for the objective of the Owned Objects Certificates Execution Latency SLO."
  default     = "7d"

  validation {
    condition     = contains(["7d", "30d", "90d", "custom"], var.owned_objects_certificates_execution_latency_timeframe)
    error_message = "The 'owned_objects_certificates_execution_latency_timeframe' must be one of the following values: '7d', '30d', '90d', 'custom'."
  }
}

variable "owned_objects_certificates_execution_latency_target" {
  type        = number
  description = "The objective's target (0-100) for Owned Objects Certificates Execution Latency SLO."
  default     = 99.9
}

variable "owned_objects_certificates_execution_latency_warning" {
  type        = number
  description = "The warning value (0-100) for the Owned Objects Certificates Execution Latency SLO. It must be greater than the target value."
  default     = 99.95
}

variable "shared_objects_certificates_execution_latency_enabled" {
  description = "Enables SLO monitoring for Shared Objects Certificates Execution Latency on the Sui validator, a critical metric for assessing network participation efficiency."
  type        = string
  default     = "true"
}

variable "shared_objects_certificates_execution_latency_monitor_ids" {
  type        = list(string)  
  description = "A static set of monitor IDs to use as part of the Shared Objects Certificates Execution Latency SLO."
  default     = []
}

variable "shared_objects_certificates_execution_latency_timeframe" {
  type        = string
  description = "The time frame for the objective of the Shared Objects Certificates Execution Latency SLO."
  default     = "7d"

  validation {
    condition     = contains(["7d", "30d", "90d", "custom"], var.shared_objects_certificates_execution_latency_timeframe)
    error_message = "The 'shared_objects_certificates_execution_latency_timeframe' must be one of the following values: '7d', '30d', '90d', 'custom'."
  }
}

variable "shared_objects_certificates_execution_latency_target" {
  type        = number
  description = "The objective's target (0-100) for Shared Objects Certificates Execution Latency SLO."
  default     = 99.9
}

variable "shared_objects_certificates_execution_latency_warning" {
  type        = number
  description = "The warning value (0-100) for the Shared Objects Certificates Execution Latency SLO. It must be greater than the target value."
  default     = 99.95
}

variable "certificate_creation_rate_enabled" {
  description = "Enables SLO monitoring for Certificate Creation Rate on the Sui validator, a critical metric for assessing network participation efficiency."
  type        = string
  default     = "true"
}

variable "certificate_creation_rate_monitor_ids" {
  type        = list(string)  
  description = "A static set of monitor IDs to use as part of the Certificate Creation Rate SLO."
  default     = []
}

variable "certificate_creation_rate_timeframe" {
  type        = string
  description = "The time frame for the objective of the Certificate Creation Rate SLO."
  default     = "7d"

  validation {
    condition     = contains(["7d", "30d", "90d", "custom"], var.certificate_creation_rate_timeframe)
    error_message = "The 'certificate_creation_rate_timeframe' must be one of the following values: '7d', '30d', '90d', 'custom'."
  }
}

variable "certificate_creation_rate_target" {
  type        = number
  description = "The objective's target (0-100) for Certificate Creation Rate SLO."
  default     = 99.9
}

variable "certificate_creation_rate_warning" {
  type        = number
  description = "The warning value (0-100) for the Certificate Creation Rate SLO. It must be greater than the target value."
  default     = 99.95
}

variable "consensus_reliability_enabled" {
  description = "Enables SLO monitoring for Consensus Reliability on the Sui validator, a critical metric for assessing network participation efficiency."
  type        = string
  default     = "true"
}

variable "consensus_reliability_monitor_ids" {
  type        = list(string)  
  description = "A static set of monitor IDs to use as part of the Consensus Reliability SLO."
  default     = []
}

variable "consensus_reliability_timeframe" {
  type        = string
  description = "The time frame for the objective of the Consensus Reliability SLO."
  default     = "7d"

  validation {
    condition     = contains(["7d", "30d", "90d", "custom"], var.consensus_reliability_timeframe)
    error_message = "The 'consensus_reliability_timeframe' must be one of the following values: '7d', '30d', '90d', 'custom'."
  }
}

variable "consensus_reliability_target" {
  type        = number
  description = "The objective's target (0-100) for Consensus Reliability SLO."
  default     = 99.9
}

variable "consensus_reliability_warning" {
  type        = number
  description = "The warning value (0-100) for the Consensus Reliability SLO. It must be greater than the target value."
  default     = 99.95
}