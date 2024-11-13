output "validator_slo_ids" {
  value = { for key, objective in datadog_service_level_objective.sui_validator_slo : key => objective.id }
  description = "A map of validator SLO names to their respective Datadog resource IDs."
}