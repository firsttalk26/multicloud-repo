

variable "PROJECT" {
  description = "Enter project name or id."
}

variable "vm_setting" {
  description = "Enter the settings of vm"
}

variable "enable" {
  description = "Enter the bool value to enable the module"
  type = bool
  default = false
}
