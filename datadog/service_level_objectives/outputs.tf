output "validator_slo_ids" {
  value = { for key, objective in datadog_monitor.datadog_service_level_objective : key => objective.id }
  description = "A map of validator SLO names to their respective Datadog resource IDs."
}