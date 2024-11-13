# Walrus Terraform Datadog Modules

## Walrus Terraform Datadog Modules

Welcome to the Walrus Terraform Datadog Modules directory. This directory is dedicated to providing Terraform modules that streamline the deployment of essential Datadog resources, empowering you to efficiently manage monitoring and observability for Walrus network entities. These modules are thoughtfully designed to enhance your monitoring capabilities and ensure a seamless experience when monitoring the Walrus network.

### Prerequisites

Before you begin using the Terraform modules in this directory to deploy Datadog resources for monitoring the Walrus network, ensure that you have the following prerequisites in place:

### DataDog Provider Configuration

You will need to configure the DataDog provider in your Terraform environment to establish a connection with your Datadog account. Below is an example of how to configure the provider in your Terraform configuration:

```hcl
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
```

Both **datadog_api_key** and **datadog_app_key** are unique to each Datadog account and are essential for authenticating your Terraform deployments with Datadog. To set these values, create a terraform.tfvars file in your working directory and define the keys as follows:

```hcl
datadog_api_key = "your_datadog_api_key_here"
datadog_app_key = "your_datadog_app_key_here"
```

Replace **your_datadog_api_key_here** and **your_datadog_app_key_here** with your actual Datadog API key and application key.

### Configuring Datadog Agent for Custom Metrics

To collect custom metrics from SUI Validator or Fullnode Prometheus endpoints, you need to configure the Datadog agent. Follow these steps:

#### Install Datadog Agent
1. Install the Datadog agent using the installation method appropriate for your platform. You can find installation instructions on the official Datadog website: [Datadog Agent Installation](https://docs.datadoghq.com/agent/?tab=Linux).

#### Enable Datadog Openmetrics Integration
2. Enable the Datadog Openmetrics integration through the Datadog UI on the Integrations page.

#### Configure Openmetrics Check
3. Create a configuration file named `conf.yaml` within the Datadog agent's configuration directory for the Openmetrics check. You can use the configuration file provided in this repository: `./datadog_conf/openmetrics.yaml`. This file is pre-configured to scrape SUI Validator metrics. Replace the placeholders marked in `<*>` brackets with your custom values.

#### Save the Configuration
4. Save the `conf.yaml` file and verify the Datadog agent's health checks to ensure that the configuration was saved correctly. Use the following command:

```shell
datadog-agent check openmetrics
```

#### Restart the Agent

Restart the Datadog agent to apply the new configuration. The agent will now scrape metrics from the SUI Validator Prometheus endpoint.

#### Monitor Custom Metrics

You can now explore custom metrics from the Walrus Storage Node in the Datadog UI's metrics explorer. Additionally, you can add multiple targets to the Openmetrics configuration file to scrape metrics from multiple servers.

With the DataDog provider and Openmetrics check configured correctly, you'll be ready to use the Terraform modules to deploy and manage Datadog resources for monitoring the Walrus network effectively.

### Modules

Explore the specialized modules available within this directory:

- [**dashboards**](./dashboards/): This subdirectory contains Terraform modules tailored for creating and managing Datadog dashboards specifically configured to visualize critical data and insights related to the Walrus network and its components.

Feel free to navigate to the subdirectory that aligns with your specific monitoring needs. Each subdirectory's README provides detailed information on how to use the corresponding Terraform modules, along with configuration options and best practices.

Choose the module that suits your requirements and leverage the power of Datadog for monitoring and ensuring the performance and reliability of the Walrus network.

## Usage example

```hcl
module "datadog_walrus_dashboards" {
  source = "./datadog/dashboards"
}
```

This code snippet demonstrates how to use Terraform modules to deploy Datadog monitoring for the SUI Validator. It includes the following modules:

- `datadog_walrus_dashboards`: Deploys Datadog dashboards.