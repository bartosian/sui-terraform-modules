# SUI Terraform Modules

Welcome to the Terraform Modules for SUI Network, your all-in-one solution for deploying, monitoring, and managing SUI infrastructure with ease.

![Validator Performance Dashboard](static/images/dashboard.png)

## Key Features
- **Infrastructure Deployment:** Easily deploy and manage your SUI network infrastructure using modular and scalable Terraform modules.
- **Comprehensive Monitoring:** Gain full visibility into the performance of both networks with built-in Datadog monitors, alerts, and Service Level Objectives (SLOs) developed based on requirements provided by SUI Foundation and Mysten Labs.
- **Validator, Full Node, and Storage Node Observability:** Monitor the performance of your SUI validators, full nodes, and Walrus storage nodes with detailed metrics and dashboards.
- **Network Overview:** Get a comprehensive overview of the health and status of both SUI and Walrus networks with ease.

With these modules, you can create SLO monitors that align with the standards and requirements set by SUI Foundation and Mysten Labs. Ensure the reliability and efficiency of your SUI and Walrus infrastructure while maintaining full control and customization over monitoring and alerting processes.

Get started today and elevate your infrastructure management for SUI and Walrus with these Terraform Modules.

## Modules

This repository is organized into individual modules located in respective subdirectories. Each subdirectory includes a README file with comprehensive information on module dependencies, input variables, output details, and deployment instructions to guide successful usage.

### Module List

- [Sui](./sui): Contains modules for deploying and monitoring SUI network infrastructure, including configurations for validator and full node observability. Refer to the README for detailed information on Datadog resources, dashboards, and alerts tailored for the SUI ecosystem.

- [Walrus](./walrus): Contains modules specifically for monitoring Walrus network infrastructure, with Datadog configurations that track node performance metrics. The README includes details on module requirements, input parameters, and step-by-step deployment instructions.

Please select the module that aligns with your needs and consult its dedicated README for an extensive overview of its usage and deployment guidelines.

## License

Copyright 2024 BartestneT

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.