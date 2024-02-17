variable "db_setting" {
  description = "Enter the settings of db"
}

variable "project" {
  description = "Enter project name or id."
}

variable "enable" {
  description = "Enter the bool value to enable the module"
  type = bool
  default = false
}