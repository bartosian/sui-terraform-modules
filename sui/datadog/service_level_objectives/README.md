# SUI Datadog SLO

## Purpose

This module is designed for the easy creation of Service Level Objectives (SLOs) to monitor and visualize the performance and statistics of SUI Validators. It is tailored to generate the following Service Level Objectives (SLOs):

- SUI Validator Consensus Latency
- SUI Validator Owned Objects Certificates Execution Latency
- SUI Validator Shared Objects Certificates Execution Latency
- SUI Validator Consensus Reliability Rate
- SUI Validator Consensus Proposal Rate

## Usage example

```hcl
module "datadog-slo-sui" {
  source = "./sui-terraform-modules/datadog/service_level_objectives"

  name = "my_validator_name"
  service = "validator"
  chain_id = "4c78adac"
  environment = "testnet"

  consensus_latency_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_high_consensus_latency"]
  ]

  owned_objects_certificates_execution_latency_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_high_owned_objects_certificates_execution_latency"]
  ]

  shared_objects_certificates_execution_latency_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_high_shared_objects_certificates_execution_latency"]
  ]

  certificate_creation_rate_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_low_certificate_creation_rate"]
  ]

  consensus_reliability_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_low_consensus_proposal_rate"]
  ]
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
| <a name="variable_name"></a> [name](#variable\_name) | Name of the entity monitored within the SUI Network. This name is used to uniquely identify the monitor's target within Datadog. | `string` | - | yes |
| <a name="variable_environment"></a> [environment](#variable\_environment) | Deployment environment of the SUI Network being monitored. Common values include 'mainnet', 'testnet', or custom environment names. Default is set to 'testnet'. | `string` | `"testnet"` | no |
| <a name="variable_service"></a> [service](#variable\_service) | Type of service within the SUI Network that is being monitored. For instance, 'validator' represents a node that participates in consensus. Default is set to 'validator'. | `string` | `"validator"` | no |
| <a name="variable_chain_id"></a> [chain_id](#variable\_chain\_id) | Unique identifier for the blockchain within the SUI Network. This ID is used to distinguish between different chains or networks. Default is set to a specific chain identifier. | `string` | `"4c78adac"` | no |
| <a name="variable_tags"></a> [tags](#variable\_tags) | A list of tags to be associated with the Datadog SLO. Tags are key-value pairs that help in categorizing and filtering service level objectives across different environments, teams, or service types, enhancing manageability and visibility. | `list(string)` | `[]` | no |
| <a name="variable_consensus_latency_enabled"></a> [consensus_latency_enabled](#variable\_consensus\_latency\_enabled) | Enables SLO monitoring for consensus latency on the Sui validator, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_consensus_latency_monitor_ids"></a> [consensus_latency_monitor_ids](#variable\_consensus\_latency\_monitor\_ids) | A static set of monitor IDs to use as part of the consensus latency SLO. | `list(string)` | `[]` | no |
| <a name="variable_consensus_latency_timeframe"></a> [consensus_latency_timeframe](#variable\_consensus\_latency\_timeframe) | The time frame for the objective of the consensus latency SLO. | `string` | `"7d"` | no |
| <a name="variable_consensus_latency_target"></a> [consensus_latency_target](#variable\_consensus\_latency\_target) | The objective's target (0-100) for consensus latency SLO. | `number` | `99.9` | no |
| <a name="variable_consensus_latency_warning"></a> [consensus_latency_warning](#variable\_consensus\_latency\_warning) | The warning value (0-100) for the consensus latency SLO. It must be greater than the target value. | `number` | `99.95` | no |
| <a name="variable_owned_objects_certificates_execution_latency_enabled"></a> [owned_objects_certificates_execution_latency_enabled](#variable\_owned\_objects\_certificates\_execution\_latency\_enabled) | Enables SLO monitoring for Owned Objects Certificates Execution Latency on the Sui validator, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_owned_objects_certificates_execution_latency_monitor_ids"></a> [owned_objects_certificates_execution_latency_monitor_ids](#variable\_owned\_objects\_certificates\_execution\_latency\_monitor\_ids) | A static set of monitor IDs to use as part of the Owned Objects Certificates Execution Latency SLO. | `list(string)` | `[]` | no |
| <a name="variable_owned_objects_certificates_execution_latency_timeframe"></a> [owned_objects_certificates_execution_latency_timeframe](#variable\_owned\_objects\_certificates\_execution\_latency\_timeframe) | The time frame for the objective of the Owned Objects Certificates Execution Latency SLO. | `string` | `"7d"` | no |
| <a name="variable_owned_objects_certificates_execution_latency_target"></a> [owned_objects_certificates_execution_latency_target](#variable\_owned\_objects\_certificates\_execution\_latency\_target) | The objective's target (0-100) for Owned Objects Certificates Execution Latency SLO. | `number` | `99.9` | no |
| <a name="variable_owned_objects_certificates_execution_latency_warning"></a> [owned_objects_certificates_execution_latency_warning](#variable\_owned\_objects\_certificates\_execution\_latency\_warning) | The warning value (0-100) for the Owned Objects Certificates Execution Latency SLO. It must be greater than the target value. | `number` | `99.95` | no |
| <a name="variable_shared_objects_certificates_execution_latency_enabled"></a> [shared_objects_certificates_execution_latency_enabled](#variable\_shared\_objects\_certificates\_execution\_latency\_enabled) | Enables SLO monitoring for Shared Objects Certificates Execution Latency on the Sui validator, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_shared_objects_certificates_execution_latency_monitor_ids"></a> [shared_objects_certificates_execution_latency_monitor_ids](#variable\_shared\_objects\_certificates\_execution\_latency\_monitor\_ids) | A static set of monitor IDs to use as part of the Shared Objects Certificates Execution Latency SLO. | `list(string)` | `[]` | no |
| <a name="variable_shared_objects_certificates_execution_latency_timeframe"></a> [shared_objects_certificates_execution_latency_timeframe](#variable\_shared\_objects\_certificates\_execution\_latency\_timeframe) | The time frame for the objective of the Shared Objects Certificates Execution Latency SLO. | `string` | `"7d"` | no |
| <a name="variable_shared_objects_certificates_execution_latency_target"></a> [shared_objects_certificates_execution_latency_target](#variable\_shared\_objects\_certificates\_execution\_latency\_target) | The objective's target (0-100) for Shared Objects Certificates Execution Latency SLO. | `number` | `99.9` | no |
| <a name="variable_shared_objects_certificates_execution_latency_warning"></a> [shared_objects_certificates_execution_latency_warning](#variable\_shared\_objects\_certificates\_execution\_latency\_warning) | The warning value (0-100) for the Shared Objects Certificates Execution Latency SLO. It must be greater than the target value. | `number` | `99.95` | no |
| <a name="variable_certificate_creation_rate_enabled"></a> [certificate_creation_rate_enabled](#variable\_certificate\_creation\_rate\_enabled) | Enables SLO monitoring for Certificate Creation Rate on the Sui validator, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_certificate_creation_rate_monitor_ids"></a> [certificate_creation_rate_monitor_ids](#variable\_certificate\_creation\_rate\_monitor\_ids) | A static set of monitor IDs to use as part of the Certificate Creation Rate SLO. | `list(string)` | `[]` | no |
| <a name="variable_certificate_creation_rate_timeframe"></a> [certificate_creation_rate_timeframe](#variable\_certificate\_creation\_rate\_timeframe) | The time frame for the objective of the Certificate Creation Rate SLO. | `string` | `"7d"` | no |
| <a name="variable_certificate_creation_rate_target"></a> [certificate_creation_rate_target](#variable\_certificate\_creation\_rate\_target) | The objective's target (0-100) for Certificate Creation Rate SLO. | `number` | `99.9` | no |
| <a name="variable_certificate_creation_rate_warning"></a> [certificate_creation_rate_warning](#variable\_certificate\_creation\_rate\_warning) | The warning value (0-100) for the Certificate Creation Rate SLO. It must be greater than the target value. | `number` | `99.95` | no |
| <a name="variable_consensus_reliability_enabled"></a> [consensus_reliability_enabled](#variable\_consensus\_reliability\_enabled) | Enables SLO monitoring for Consensus Reliability on the Sui validator, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_consensus_reliability_monitor_ids"></a> [consensus_reliability_monitor_ids](#variable\_consensus\_reliability\_monitor\_ids) | A static set of monitor IDs to use as part of the Consensus Reliability SLO. | `list(string)` | `[]` | no |
| <a name="variable_consensus_reliability_timeframe"></a> [consensus_reliability_timeframe](#variable\_consensus\_reliability\_timeframe) | The time frame for the objective of the Consensus Reliability SLO. | `string` | `"7d"` | no |
| <a name="variable_consensus_reliability_target"></a> [consensus_reliability_target](#variable\_consensus\_reliability\_target) | The objective's target (0-100) for Consensus Reliability SLO. | `number` | `99.9` | no |
| <a name="variable_consensus_reliability_warning"></a> [consensus_reliability_warning](#variable\_consensus\_reliability\_warning) | The warning value (0-100) for the Consensus Reliability SLO. It must be greater than the target value. | `number` | `99.95` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_validator_slo_ids"></a> [output\_validator\_slo\_ids](#output\_validator\_slo\_ids) | A map of validator SLO names to their respective Datadog resource IDs |
<!-- END_TF_DOCS -->
## Resource Documentation
* [Datadog SLO Documentation](https://docs.datadoghq.com/service_management/service_level_objectives/)