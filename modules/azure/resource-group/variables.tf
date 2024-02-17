variable "name" {
  description = "Enter the name of resource group"
  nullable = false
  validation {
    condition = can(regex("^[a-z0-9]+$",var.name)) && !contains(["_", "-"], var.name)
    error_message = "Please enter alphanumeric in small case also it should not contain ('_' and '-')."
  }
}

variable "location" {
  description = "Enter the location of resource group"
  nullable = false
}

variable "enable" {
  description = "true/false"
  default = false
  nullable = true
}