
variable "enable" {
  description = "Enter the bool value to enable the module"
  type = bool
  default = false
}

variable "vpc_setting" {
  description = "VPC settings"
}

variable "subnet_setting" {
  description = "Subnet settings"
}
variable "project" {
  description = "Enter the project name of vpc network"
  type        = string
}



variable "firewall_rules" {
  type = list(object({
    name         = string
    description  = string
    network_name = string
    direction    = string
    action       = string
    protocol     = string
    ports        = list(string)
    source_ips   = list(string)
  }))
}

variable "firewall_destination_tags" {
  description = "Destination vm tags"
}