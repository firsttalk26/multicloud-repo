variable "name" {
  description = "Enter the name of virtual network"
  nullable = false
  validation {
    condition = can(regex("^[a-z0-9]+$",var.name)) && !contains(["_", "-"], var.name)
    error_message = "Please enter alphanumeric in small case also it should not contain ('_' and '-')."
  }
}

variable "location" {
    description = "location of network resources"
    nullable = true
}

variable "resource_group_name"{
    description = "Resource group network resources"
    nullable = true
}

variable "address_space"{
    description = "Address space of Vnet"
    nullable = false
}

variable "tags" {
    description = "Tags of azure network"
  }