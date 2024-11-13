# SUI Datadog Monitors

## Purpose

This module is designed for the easy creation of Datadog Monitors to monitor and visualize the performance and statistics of SUI Validators. It is tailored to generate the following Datadog Monitors:

- SUI Validator High Consensus Latency
- SUI Validator High Owned Objects Certificates Execution Latency
- SUI Validator High Shared Objects Certificates Execution Latency
- SUI Validator Low Certificate Creation Rate
- SUI Validator Low Checkpoints Execution Rate
- SUI Validator Low Consensus Proposal Rate
- SUI Validator Low Rounds Progression

## Usage example

```hcl
module "datadog-monitors-sui" {
  source = "./sui-terraform-modules/datadog/monitors"

  name = "my_validator_name"
  service = "validator"
  chain_id = "4c78adac"
  environment = "testnet"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.1.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="variable_name"></a> [name](#variable\_name) | Name of the entity monitored within the SUI Network. This name is used to uniquely identify the monitor's target within Datadog. | `string` | "" | yes |
| <a name="variable_environment"></a> [environment](#variable\_environment) | Deployment environment of the SUI Network being monitored. Common values include 'mainnet', 'testnet', or custom environment names. Default is set to 'testnet'. | `string` | `"testnet"` | no |
| <a name="variable_service"></a> [service](#variable\_service) | Type of service within the SUI Network that is being monitored. For instance, 'validator' represents a node that participates in consensus. Default is set to 'validator'. | `string` | `"validator"` | no |
| <a name="variable_chain_id"></a> [chain\_id](#variable\_chain\_id) | Unique identifier for the blockchain within the SUI Network. This ID is used to distinguish between different chains or networks. Default is set to a specific chain identifier. | `string` | `"4c78adac"` | no |
| <a name="variable_evaluation_delay"></a> [evaluation\_delay](#variable\_evaluation\_delay) | The delay, in seconds, before evaluating the metric to account for data ingestion latency. Helps ensure data completeness for accurate monitoring. | `number` | `300` | no |
| <a name="variable_notify_no_data"></a> [notify_no_data](#variable\_notify\_no\_data) | Enables alerts for 'no data' events, indicating possible issues with data reporting or collection from the Sui validator. | `bool` | `true` | no |
| <a name="variable_no_data_timeframe"></a> [no_data\_timeframe](#variable\_no\_data\_timeframe) | Duration, in minutes, to wait before alerting on a 'no data' condition, signaling potential interruptions in data flow or metric collection. | `number` | `15` | no |
| <a name="variable_notification_preset_name"></a> [notification\_preset\_name](#variable\_notification\_preset\_name) | Configures the detail level in monitor notifications. Options: 'show_all', 'hide_query', 'hide_handles', 'hide_all'. Tailors notifications to include essential information. | `string` | `"hide_handles"` | no |
| <a name="variable_renotify_interval"></a> [renotify\_interval](#variable\_renotify\_interval) | Interval, in minutes, between re-notifications for unresolved issues, ensuring timely follow-ups on critical Sui validator performance metrics. | `number` | `15` | no |
| <a name="variable_renotify_occurrences"></a> [renotify\_occurrences](#variable\_renotify\_occurrences) | Specifies the maximum number of re-notification messages for unresolved alerts, controlling alert frequency on ongoing issues. | `number` | `2` | no |
| <a name="variable_renotify_statuses"></a> [renotify\_statuses](#variable\_renotify\_statuses) | Defines the alert statuses (e.g., 'alert', 'warn', 'no data') that trigger re-notifications, allowing for targeted follow-ups on specific conditions. | `list(string)` | `["alert", "warn", "no data"]` | no |
| <a name="variable_notification_targets"></a> [notification\_targets](#variable\_notification\_targets) | A map specifying notification targets for different alert thresholds. It allows defining custom notification channels for 'critical' and 'warning' alerts, ensuring appropriate alert routing. Each channel should be specified with a unique identifier, prefixed with '@'. Format: {'critical': ['@channel1', '@user'], 'warning': ['@channel2']}. | `map(list(string))` | `{}` | no |
| <a name="variable_tags"></a> [tags](#variable\_tags) | A list of tags to be associated with the Datadog monitors. Tags are key-value pairs that help in categorizing and filtering monitors across different environments, teams, or service types, enhancing manageability and visibility. | `list(string)` | `[]` | no |
| <a name="variable_high_consensus_latency_enabled"></a> [high_consensus_latency_enabled](#variable\_high\_consensus\_latency\_enabled) | Enables monitoring for high consensus latency on the Sui validator, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_high_consensus_latency_message"></a> [high_consensus_latency_message](#variable\_high\_consensus\_latency\_message) | Customizable notification message for the High Consensus Latency monitor, allowing for tailored alerts specific to Sui validator operations. | `string` | "" | no |
| <a name="variable_high_consensus_latency_escalation_message"></a> [high_consensus_latency_escalation_message](#variable\_high\_consensus\_latency\_escalation\_message) | A message to include with a re-notification for the High Consensus Latency monitor escalation. | `string` | "" | no |
| <a name="variable_high_consensus_latency_aggregator"></a> [high_consensus_latency_aggregator](#variable\_high\_consensus\_latency\_aggregator) | Aggregation method for evaluating consensus latency over the specified timeframe, crucial for identifying performance trends. Valid options are 'min', 'max', 'avg'. | `string` | `"avg"` | no |
| <a name="variable_high_consensus_latency_timeframe"></a> [high_consensus_latency_timeframe](#variable\_high\_consensus\_latency\_timeframe) | Time window for assessing High Consensus Latency, setting the scope for performance evaluation of the Sui validator. Valid options are 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'. | `string` | `"last_5m"` | no |
| <a name="variable_high_consensus_latency_threshold_critical"></a> [high_consensus_latency_threshold_critical](#variable\_high\_consensus\_latency\_threshold\_critical) | Critical alert threshold for consensus latency (in seconds), beyond which the validator's performance is considered severely impacted. | `number` | `10` | no |
| <a name="variable_high_consensus_latency_threshold_warning"></a> [high_consensus_latency_threshold_warning](#variable\_high\_consensus\_latency\_threshold\_warning) | Warning threshold for consensus latency (in seconds), indicating the onset of performance degradation that may impact validator efficiency. | `number` | `8` | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_enabled"></a> [high_owned_objects_certificates_execution_latency_enabled](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_enabled) | Activates monitoring for high execution latency of owned objects' certificates, crucial for ensuring timely transaction processing. | `string` | `"true"` | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_message"></a> [high_owned_objects_certificates_execution_latency_message](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_message) | Custom message for alerts on high execution latency of owned objects' certificates, enabling specific guidance for troubleshooting. | `string` | "" | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_escalation_message"></a> [high_owned_objects_certificates_execution_latency_escalation_message](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_escalation\_message) | A custom message to include with a re-notification for the High Owned Objects Certificates Execution Latency monitor escalation. | `string` | "" | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_aggregator"></a> [high_owned_objects_certificates_execution_latency_aggregator](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_aggregator) | Determines how execution latency data is aggregated (e.g., 'avg'), essential for accurate performance assessment over time. | `string` | `"avg"` | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_timeframe"></a> [high_owned_objects_certificates_execution_latency_timeframe](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_timeframe) | Defines the observation period for execution latency monitoring, vital for identifying and addressing performance issues promptly. | `string` | `"last_5m"` | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_threshold_critical"></a> [high_owned_objects_certificates_execution_latency_threshold_critical](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_threshold\_critical) | Critical latency threshold in milliseconds for owned objects' certificates execution, highlighting severe performance issues. | `number` | `3000` | no |
| <a name="variable_high_owned_objects_certificates_execution_latency_threshold_warning"></a> [high_owned_objects_certificates_execution_latency_threshold_warning](#variable\_high\_owned\_objects\_certificates\_execution\_latency\_threshold\_warning) | Warning threshold in milliseconds for execution latency, indicating potential concerns that could escalate if unaddressed. | `number` | `2000` | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_enabled"></a> [high_shared_objects_certificates_execution_latency_enabled](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_enabled) | Enables alerts for high latency in executing shared objects' certificates, key for maintaining overall network responsiveness. | `string` | `"true"` | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_message"></a> [high_shared_objects_certificates_execution_latency_message](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_message) | Alert message customization for high execution latency of shared objects' certificates, facilitating targeted response actions. | `string` | "" | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_escalation_message"></a> [high_shared_objects_certificates_execution_latency_escalation_message](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_escalation\_message) | A custom message to include with a re-notification for the High Shared Objects Certificates Execution Latency monitor escalation. | `string` | "" | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_aggregator"></a> [high_shared_objects_certificates_execution_latency_aggregator](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_aggregator) | Aggregation strategy (e.g., 'avg') for latency metrics, crucial for a balanced view of network performance across time intervals. | `string` | `"avg"` | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_timeframe"></a> [high_shared_objects_certificates_execution_latency_timeframe](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_timeframe) | Specifies the monitoring window for evaluating execution latency, essential for timely detection of performance degradation. | `string` | `"last_5m"` | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_threshold_critical"></a> [high_shared_objects_certificates_execution_latency_threshold_critical](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_threshold\_critical) | Sets the critical alert threshold in seconds for shared objects' certificates execution latency, marking unacceptable performance levels. | `number` | `5` | no |
| <a name="variable_high_shared_objects_certificates_execution_latency_threshold_warning"></a> [high_shared_objects_certificates_execution_latency_threshold_warning](#variable\_high\_shared\_objects\_certificates\_execution\_latency\_threshold\_warning) | Warning level for execution latency in seconds, serving as an early indicator of potential slowdowns in transaction processing. | `number` | `4` | no |
| <a name="variable_low_certificate_creation_rate_enabled"></a> [low_certificate_creation_rate_enabled](#variable\_low\_certificate\_creation\_rate\_enabled) | Turns on monitoring for low certificate creation rates, indicative of underperformance in transaction validation or network participation. | `string` | `"true"` | no |
| <a name="variable_low_certificate_creation_rate_message"></a> [low_certificate_creation_rate_message](#variable\_low\_certificate\_creation\_rate\_message) | Allows for a custom alert message when the certificate creation rate falls below expected levels, aiding in prompt issue identification. | `string` | "" | no |
| <a name="variable_low_certificate_creation_rate_escalation_message"></a> [low_certificate_creation_rate_escalation_message](#variable\_low\_certificate\_creation\_rate\_escalation\_message) | A custom message to include with a re-notification for the Low Certificate Creation Rate monitor escalation. | `string` | "" | no |
| <a name="variable_low_certificate_creation_rate_aggregator"></a> [low_certificate_creation_rate_aggregator](#variable\_low\_certificate\_creation\_rate\_aggregator) | Aggregator function (e.g., 'avg') for calculating the certificate creation rate, important for accurate monitoring of validator activity. | `string` | `"avg"` | no |
| <a name="variable_low_certificate_creation_rate_timeframe"></a> [low_certificate_creation_rate_timeframe](#variable\_low\_certificate\_creation\_rate\_timeframe) | Observation period for certificate creation rate, critical for assessing the validator's contribution to the network's security and efficiency. | `string` | `"last_5m"` | no |
| <a name="variable_low_certificate_creation_rate_threshold_critical"></a> [low_certificate_creation_rate_threshold_critical](#variable\_low\_certificate\_creation\_rate\_threshold\_critical) | Critical threshold for certificate creation rate, in certificates per second, below which the validator's activity is considered alarmingly low. | `number` | `0.5` | no |
| <a name="variable_low_certificate_creation_rate_threshold_warning"></a> [low_certificate_creation_rate_threshold_warning](#variable\_low\_certificate\_creation\_rate\_threshold\_warning) | Warning threshold for certificate creation rate, indicating early signs of reduced validator engagement or network issues. | `number` | `1` | no |
| <a name="variable_low_checkpoints_execution_rate_enabled"></a> [low_checkpoints_execution_rate_enabled](#variable\_low\_checkpoints\_execution\_rate\_enabled) | Enables the monitor for tracking low checkpoints execution rate, crucial for identifying delays or inefficiencies in processing checkpoints. | `string` | `"true"` | no |
| <a name="variable_low_checkpoints_execution_rate_message"></a> [low_checkpoints_execution_rate_message](#variable\_low\_checkpoints\_execution\_rate\_message) | Customizable alert message for low checkpoints execution rate, allowing for specific instructions or insights to be communicated during alerts. | `string` | "" | no |
| <a name="variable_low_checkpoints_execution_rate_escalation_message"></a> [low_checkpoints_execution_rate_escalation_message](#variable\_low\_checkpoints\_execution\_rate\_escalation\_message) | A custom message to include with a re-notification for the Low Checkpoints Execution Rate monitor escalation. | `string` | "" | no |
| <a name="variable_low_checkpoints_execution_rate_aggregator"></a> [low_checkpoints_execution_rate_aggregator](#variable\_low\_checkpoints\_execution\_rate\_aggregator) | Determines the aggregation method (e.g., 'max') for calculating the checkpoints execution rate, vital for assessing overall performance trends. | `string` | `"max"` | no |
| <a name="variable_low_checkpoints_execution_rate_timeframe"></a> [low_checkpoints_execution_rate_timeframe](#variable\_low\_checkpoints\_execution\_rate\_timeframe) | Defines the evaluation period for the low checkpoints execution rate monitor, setting the context for performance analysis. | `string` | `"last_5m"` | no |
| <a name="variable_low_checkpoints_execution_rate_shift_timeframe"></a> [low_checkpoints_execution_rate_shift_timeframe](#variable\_low\_checkpoints\_execution\_rate\_shift\_timeframe) | Specifies the comparison timeframe for assessing changes in the checkpoints execution rate, aiding in trend analysis and anomaly detection. | `string` | `"last_5m"` | no |
| <a name="variable_low_checkpoints_execution_rate_threshold_critical"></a> [low_checkpoints_execution_rate_threshold_critical](#variable\_low\_checkpoints\_execution\_rate\_threshold\_critical) | Sets the critical alert threshold for checkpoints execution rate, below which the performance is considered significantly impaired. | `number` | `0.5` | no |
| <a name="variable_low_checkpoints_execution_rate_threshold_warning"></a> [low_checkpoints_execution_rate_threshold_warning](#variable\_low\_checkpoints\_execution\_rate\_threshold\_warning) | Establishes the warning threshold for checkpoints execution rate, indicating the onset of potential performance issues. | `number` | `1` | no |
| <a name="variable_low_consensus_proposal_rate_enabled"></a> [low_consensus_proposal_rate_enabled](#variable\_low\_consensus\_proposal\_rate\_enabled) | Activates the monitor for observing low consensus proposal rates, essential for maintaining the validator's active participation in consensus. | `string` | `"true"` | no |
| <a name="variable_low_consensus_proposal_rate_message"></a> [low_consensus_proposal_rate_message](#variable\_low\_consensus\_proposal\_rate\_message) | Allows for a tailored alert message regarding low consensus proposal rates, facilitating targeted actions for maintaining network integrity. | `string` | "" | no |
| <a name="variable_low_consensus_proposal_rate_escalation_message"></a> [low_consensus_proposal_rate_escalation_message](#variable\_low\_consensus\_proposal\_rate\_escalation\_message) | A custom message to include with a re-notification for the Low Consensus Proposal Rate monitor escalation. | `string` | "" | no |
| <a name="variable_low_consensus_proposal_rate_aggregator"></a> [low_consensus_proposal_rate_aggregator](#variable\_low\_consensus\_proposal\_rate\_aggregator) | Specifies the aggregation method (e.g., 'avg') for evaluating consensus proposal rates, critical for understanding participation effectiveness. | `string` | `"avg"` | no |
| <a name="variable_low_consensus_proposal_rate_timeframe"></a> [low_consensus_proposal_rate_timeframe](#variable\_low\_consensus\_proposal\_rate\_timeframe) | Sets the timeframe for monitoring low consensus proposal rates, crucial for timely detection of decreased network engagement. | `string` | `"last_5m"` | no |
| <a name="variable_low_consensus_proposal_rate_threshold_critical"></a> [low_consensus_proposal_rate_threshold_critical](#variable\_low\_consensus\_proposal\_rate\_threshold\_critical) | Critical alert threshold for consensus proposal rates, below which indicates significant issues with validator's engagement in consensus. | `number` | `1` | no |
| <a name="variable_low_consensus_proposal_rate_threshold_warning"></a> [low_consensus_proposal_rate_threshold_warning](#variable\_low\_consensus\_proposal\_rate\_threshold\_warning) | Warning level for consensus proposal rates, signaling early warnings of reduced engagement in the consensus process. | `number` | `0.8` | no |
| <a name="variable_low_rounds_progression_enabled"></a> [low_rounds_progression_enabled](#variable\_low\_rounds\_progression\_enabled) | Enables monitoring for low rounds progression, vital for identifying blocks or consensus stages that are not advancing as expected. | `string` | `"true"` | no |
| <a name="variable_low_rounds_progression_message"></a> [low_rounds_progression_message](#variable\_low\_rounds\_progression\_message) | Custom message for alerts on low rounds progression, providing context or remediation steps for addressing the detected issues. | `string` | "" | no |
| <a name="variable_low_rounds_progression_escalation_message"></a> [low_rounds_progression_escalation_message](#variable\_low\_rounds\_progression\_escalation\_message) | A custom message to include with a re-notification for the Low Rounds Progression monitor escalation. | `string` | "" | no |
| <a name="variable_low_rounds_progression_aggregator"></a> [low_rounds_progression_aggregator](#variable\_low\_rounds\_progression\_aggregator) | Aggregation method (e.g., 'max') for the low rounds progression monitor, important for evaluating the progression efficiency of rounds. | `string` | `"max"` | no |
| <a name="variable_low_rounds_progression_timeframe"></a> [low_rounds_progression_timeframe](#variable\_low\_rounds\_progression\_timeframe) | Timeframe for assessing low rounds progression, essential for ensuring timely and effective participation in the consensus mechanism. | `string` | `"last_5m"` | no |
| <a name="variable_low_rounds_progression_shift_timeframe"></a> [low_rounds_progression_shift_timeframe](#variable\_low\_rounds\_progression\_shift\_timeframe) | Specifies the comparison timeframe for assessing changes in the rounds progression, aiding in trend analysis and anomaly detection. | `string` | `"last_5m"` | no |
| <a name="variable_low_rounds_progression_threshold_critical"></a> [low_rounds_progression_threshold_critical](#variable\_low\_rounds\_progression\_threshold\_critical) | Defines the critical threshold for rounds progression alerts, indicating no advancement in consensus rounds within the specified timeframe. | `number` | `0` | no |
| <a name="variable_low_rounds_progression_threshold_warning"></a> [low_rounds_progression_threshold_warning](#variable\_low\_rounds\_progression\_threshold\_warning) | Warning level for rounds progression, designed to alert on early signs of slowing or stalling in consensus round advancement. | `number` | `0.5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_validator_monitor_ids"></a> [output\_validator\_monitor\_ids](#output\_validator\_monitor\_ids) | A map of validator monitor names to their respective Datadog monitor IDs |
<!-- END_TF_DOCS -->
## Resource Documentation
* [Datadog Monitors Documentation](https://docs.datadoghq.com/monitors/)