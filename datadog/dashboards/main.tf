# Resource    : Datadog Dashboard JSON
# Description : Terraform resource to create and manage Datadog dashboard for SUI Validator Performance.
resource "datadog_dashboard_json" "validator_performance_dashboard" {
  dashboard = file("${path.module}/templates/validator_performance_dashboard.json")
}