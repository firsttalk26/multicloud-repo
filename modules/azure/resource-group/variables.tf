variable "name" {
  description = "Enter the name of resource group"
  nullable = false
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