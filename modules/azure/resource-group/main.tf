resource "azurerm_resource_group" "resource_group" {
  count = var.enable ? 1 : 0
  name     = var.name
  location = var.location
}


output "resource_group_name" {
  value = azurerm_resource_group.resource_group[0].name
}

output "resource_group_location" {
  value = azurerm_resource_group.resource_group[0].location
}

output "enable" {
  value = var.enable
}

