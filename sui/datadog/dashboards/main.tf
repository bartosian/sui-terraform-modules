# Resource: Datadog Dashboard for SUI Validator Performance
# Description: This Terraform resource is designed to dynamically create and manage a Datadog dashboard dedicated to showcasing the performance metrics of SUI Validators. 
# It facilitates a comprehensive view into the operational aspects of validators, enabling users to monitor key performance indicators (KPIs) and metrics essential for maintaining the health and efficiency of the SUI network. 
# The dashboard configuration is structured to provide a holistic overview, incorporating various widgets and visualizations that reflect real-time data and trends. 
# This resource empowers administrators and network operators with actionable insights, ensuring the SUI Validators operate at their optimal performance levels.
resource "datadog_dashboard_json" "validator_performance_dashboard" {
  dashboard = file("${path.module}/templates/validator_performance_dashboard.json")
}