variable "dashboard_json" {
  type        = string
  description = "The JSON formatted definition of the Dashboard."

  validation {
    condition     = length(var.dashboard_json) > 0
    error_message = "The variable 'dashboard_json' must not be empty."
  }
}