# Walrus Datadog Dashboards

## Purpose

This module allows for the easy generation of Datadog Dashboards to monitor and visualize the performance and statistics of Walrus Storage Nodes. The purpose of this module creates the following Datadog Dashboards:

- Walrus Storage Node Performance

## Usage example

```hcl
module "datadog-dashboards-walrus" {
  source = "./walrus-terraform-modules/datadog/dashboards"
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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dashboard_url"></a> [errors\_id](#output\_dashboard\_url) | the URL of the dashboard |
<!-- END_TF_DOCS -->
## Resource Documentation
* [Datadog Dashboards Documentation](https://docs.datadoghq.com/dashboards/)