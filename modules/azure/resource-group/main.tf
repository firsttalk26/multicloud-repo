resource "azurerm_resource_group" "resource_group" {
  count = var.enable ? 1 : 0
  name     = var.name
  location = var.location
}


output "resource_group_name" {
  value = var.enable ? azurerm_resource_group.resource_group[0].name : null 
}

output "resource_group_location" {
  value = var.enable ? azurerm_resource_group.resource_group[0].location : null 
}

output "enable" {
  value = var.enable
}



