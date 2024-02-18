variable "enable" {
  description = "true/false"
  default = false
  nullable = false
}


variable "name" {
  description = "Enter the name of virtual machine"
  nullable = true
  validation {
    condition = alltrue([ for name in var.name : can(regex("^[a-z0-9]+$", name)) && !contains(["_", "-"], var.name) ]) 
    error_message = "Please ensure the 'name' field is alphanumeric in lowercase and does not contain underscores or hyphens."
  }
}

variable "location" {
  description = "Enter the location of vms.."
  validation {
    condition = can(regex("^[a-z]+$",var.location)) && !contains(["_", "-"], var.location)
    error_message = "Please enter alphanumeric in small case also it should not contain ('_' and '-')."
  }
}

variable "resource_group" {
  description = "Enter the resource group to create vm.."
}

variable "vm_size" {
  description = "Enter the size of vms.."
}

variable "tags" {
  description = "Enter the tags of resources..."
}