variable "cloud_provider" {
  description = "Which cloud provider to use (aws, gcp, or azure)"
  default     = "azure"
}

variable "ARM_SUBSCRIPTION_ID" {
  description = "Azure subscription"
}

variable "ARM_TENANT_ID" {
  description = "Tenant ID"
}
variable "ARM_CLIENT_ID" {
  description = "Azure client id"
}

variable "ARM_CLIENT_SECRET" {
  description = "Azure client secret"
}


variable "azure_resources" {
  description = "Variable for resources on Azure"
  type        = any
}
