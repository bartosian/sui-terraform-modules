variable "datadog_api_key" {
  type        = string
  description = "Datadog API key required for authentication with the Datadog platform. This key enables Terraform to create and manage resources within your Datadog account."
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog application key associated with your account. This key, used in conjunction with your API key, authorizes API access to further secure your Datadog account."
}

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
